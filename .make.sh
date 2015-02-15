dir=~/dotfiles
old_dir=~/dotfiles_old 
files="bashrc bash_profile vimrc vim"

echo "Creating $old_dir for backup of any existing dotfiles in ~"
mkdir -p $old_dir
echo "...done"
cd $dir

#  archive old things to $old_dir, symlink new things to $dir
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $old_dir"
    mv ~/.$file $old_dir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
