#!/usr/bin/env bash
# waybar custom/network module.
# Bar text mirrors the old built-in network module; the tooltip additionally
# shows the local (internal) and public (external) IP addresses.
#
# Icons are written as \u / \U escapes on purpose: the raw Nerd Font PUA
# glyphs get stripped when these files are rewritten, so keep them as escapes.

set -u

ICON_WIFI=$'\uf1eb'      # nf-fa-wifi
ICON_WIRED=$'\U000f0200' # nf-md-ethernet_cable
ICON_OFF=$'\U000f092d'   # nf-md-wifi_off
DOWN=$'⇣'
UP=$'⇡'

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/waybar-network"
mkdir -p "$STATE_DIR"
PUBIP_FILE="$STATE_DIR/pubip"
BW_FILE="$STATE_DIR/bw"
PUBIP_TTL=300 # seconds between external-IP refreshes

pango_escape() { # escape &<> for pango markup
  local s=$1
  s=${s//&/&amp;}
  s=${s//</&lt;}
  s=${s//>/&gt;}
  printf '%s' "$s"
}

human() { # bytes/sec -> human string
  awk -v b="${1:-0}" 'BEGIN{
    split("B KiB MiB GiB TiB", u, " ");
    i = 1; while (b >= 1024 && i < 5) { b /= 1024; i++ }
    if (i == 1) printf "%d %s/s", b, u[i];
    else        printf "%.1f %s/s", b, u[i]
  }'
}

emit() { # text tooltip class
  jq -nc --arg t "$1" --arg tt "$2" --arg c "$3" \
    '{text:$t, tooltip:$tt, class:$c}'
}

# --- interface backing the default route ---
iface=$(ip route show default 2>/dev/null | awk '/default/ {print $5; exit}')

if [ -z "$iface" ]; then
  emit "$ICON_OFF  Offline" "No connection" "disconnected"
  exit 0
fi

# --- local IP ---
localip=$(ip -4 -o addr show dev "$iface" 2>/dev/null \
  | awk '{print $4}' | cut -d/ -f1 | head -1)
[ -z "$localip" ] && localip="—"

# --- public IP: refreshed in the background so the bar never blocks ---
now=$(date +%s)
pub=""; pts=0
if [ -f "$PUBIP_FILE" ]; then read -r pts pub < "$PUBIP_FILE"; fi
if [ $(( now - pts )) -ge "$PUBIP_TTL" ]; then
  (
    ip=$(curl -fsS --max-time 4 https://api.ipify.org 2>/dev/null)
    if [ -n "$ip" ]; then
      printf '%s %s\n' "$(date +%s)" "$ip" > "$PUBIP_FILE.tmp" \
        && mv "$PUBIP_FILE.tmp" "$PUBIP_FILE"
    fi
  ) &
fi
[ -z "$pub" ] && pub="…"

# --- bandwidth: delta of rx/tx byte counters since the last run ---
rx=$(cat "/sys/class/net/$iface/statistics/rx_bytes" 2>/dev/null || echo 0)
tx=$(cat "/sys/class/net/$iface/statistics/tx_bytes" 2>/dev/null || echo 0)
tns=$(date +%s%N)
down_r=0; up_r=0
if [ -f "$BW_FILE" ]; then
  read -r p_if p_tns p_rx p_tx < "$BW_FILE"
  if [ "$p_if" = "$iface" ]; then
    dt=$(awk -v a="$tns" -v b="$p_tns" 'BEGIN{d=(a-b)/1e9; print (d>0)?d:0}')
    if [ "$dt" != "0" ]; then
      down_r=$(awk -v c="$rx" -v p="$p_rx" -v d="$dt" 'BEGIN{r=(c-p)/d; print (r>0)?r:0}')
      up_r=$(awk   -v c="$tx" -v p="$p_tx" -v d="$dt" 'BEGIN{r=(c-p)/d; print (r>0)?r:0}')
    fi
  fi
fi
printf '%s %s %s %s\n' "$iface" "$tns" "$rx" "$tx" > "$BW_FILE"
bw="$DOWN $(human "$down_r")  $UP $(human "$up_r")"

# --- wifi vs ethernet ---
if [ -d "/sys/class/net/$iface/wireless" ] || [ -L "/sys/class/net/$iface/phy80211" ]; then
  line=$(nmcli -t -f IN-USE,SIGNAL,SSID device wifi 2>/dev/null | awk -F: '/^\*/{print; exit}')
  signal=$(printf '%s' "$line" | cut -d: -f2)
  essid=$(printf '%s' "$line" | cut -d: -f3-)
  [ -z "$essid" ] && essid="wifi"
  [ -z "$signal" ] && signal="?"
  text="$ICON_WIFI  ${signal}%"
  head="WiFi  $(pango_escape "$essid") (${signal}%)"
else
  text="$ICON_WIRED  Wired"
  head="Wired  $(pango_escape "$iface")"
fi

tooltip=$(printf '%s\nlocal   %s\npublic  %s\n%s' "$head" "$localip" "$pub" "$bw")
emit "$text" "$tooltip" ""
