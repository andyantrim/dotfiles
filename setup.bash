echo "Prepending .bak to old files"
mv ~/.bashrc ~/.bashrc.bak
mv ~/.tmux.conf ~/.tmux.conf.bak
mv ~/.config/nvim ~/.config/nvim.bak

echo "Adding dot files"

ln -s $PWD/nvim/ ~/.config/nvim
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.tmux.conf ~/.tmux.conf

echo "Adding vim-plug to NeoVim"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
