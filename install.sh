dir=~/dotfiles
old_dir=~/dotfiles_old 

home_files="zshrc gitconfig gitexcludes vimrc"

config_files="nvim lsd espanso tmux ghostty"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "oh-my-zsh installed"
else
    echo "oh-my-zsh already installed, skipping"
fi


if ! command -v brew > /dev/null 2>&1; then
    echo "installing homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "homebrew installed"
else
    echo "homebrew already installed, skipping"
fi

echo "creating $old_dir for backup of any existing dotfiles in ~"
mkdir -p $old_dir
echo "Creating ~/.config if it doesn't exist"
mkdir -p ~/.config
echo "...done"
cd $dir

for file in $home_files; do
    if [ -e ~/.$file ]; then
        echo "backing up ~/.$file to $old_dir"
        mv ~/.$file $old_dir/
    fi
    ln -s $dir/$file ~/.$file
    echo "linking $dir/$file to ~/.$file"
done

for file in $config_files; do
    if [ -e ~/.config/$file ]; then
        echo "backing up ~/.config/$file to $old_dir"
        mv ~/.config/$file $old_dir/
    fi
    ln -s $dir/$file ~/.config/$file
    echo "linking $dir/$file to ~/.config/$file"
done

if [[ "$OSTYPE" == "darwin"* ]]; then
    if [ -f "$dir/rectangle.plist" ]; then
        echo "importing Rectangle settings..."
        defaults import com.knollsoft.Rectangle "$dir/rectangle.plist"
        echo "Rectangle settings imported"
    fi
fi

echo "done"
