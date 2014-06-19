wd=$(pwd)

# Backup any existing configuration file
[ -f "$HOME/.tmux.conf" ] && mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
[ -f "$HOME/.oh-my-zsh/themes/honukai.zsh-theme" ] && mv "$HOME/.oh-my-zsh/themes/honukai.zsh-theme" "$HOME/.oh-my-zsh/themes/honukai.zsh-theme.backup"

# Symlink all configuration files
ln -s "$wc/tmux.conf" "$HOME/.tmux.conf"
ln -s "$wc/zshrc" "$HOME/.zshrc"
ln -s "$wc/zsh-colors.zsh.theme" "$HOME/.oh-my-zsh/themes/honukai.zsh-theme"

