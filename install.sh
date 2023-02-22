#!/bin/bash
# Installation script for my arch system

CUR_DIR="$PWD"
BIN="$HOME/bin"
GPATH="$HOME/devel/gopath"
AFTER_INSTALL="$HOME/after-install"

init_home() {
    echo "Initing home..."
    mkdir -p "$BIN" "$AFTER_INSTALL" "$GPATH"
    ln -s "$CUR_DIR/backgrounds" "$HOME/backgrounds"
    ln -s "$CUR_DIR/gitconfig" "$HOME/.gitconfig"
    echo 'PATH="$PATH:$HOME/bin"' >> "$HOME/.profile"
    echo "Done init home."
}

install_packages() {
    echo "Initing packages..."
    sudo pacman -Syu firefox feh scrot xclip neovim mpv curl htop pcmanfm keepassxc \
        p7zip zip unzip rsync neofetch gcc go gdb zsh tmux git openssh yt-dlp lua \
        adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts \
        adobe-source-han-serif-kr-fonts adobe-source-han-sans-kr-fonts \
        adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts

    # yay
    cd /opt
    sudo git clone https://aur.archlinux.org/yay-git.git
    sudo chown -R "$(id -un)":"$(id -un)" /opt/yay-git
    cd /opt/yay-git
    makepkg -si
    cd "$CUR_DIR"
    yay -S nerd-fonts-liberation-mono

    echo "Done installing packages..."
}

install_base() {
    echo "Installing base..."
    local config_path="$HOME/.config"

    # i3
    mv "$config_path/i3" "$AFTER_INSTALL/i3.bak"
    ln -s "$CUR_DIR/i3-config" "$config_path/i3"

    # neovim
    mv "$config_path/nvim" "$AFTER_INSTALL/nvim.bak"
    mv "$HOME/.local/share/nvim" "$AFTER_INSTALL/local_share_nvim.bak"
    mv "$HOME/.local/state/nvim" "$AFTER_INSTALL/local_state_nvim.bak"
    mv "$HOME/.cache/nvim" "$AFTER_INSTALL/cache_nvim.bak"
    git clone https://github.com/AstroNvim/AstroNvim "$config_path/nvim"
    ln -s "$CUR_DIR/astronvim-config" "$config_path/nvim/lua/user"

    # mpv
    mv "$config_path/mpv" "$AFTER_INSTALL/mpv.bak"
    ln -s "$CUR_DIR/mpv-config" "$HOME/.config/mpv"

    # prepare go
    go env -w GOBIN="$BIN"
    go env -w GOPATH="$GPATH"
    echo "Done installing base."
}

install_scripts() {
    echo "Installing scripts..."
    git clone https://git.scarlet.house/oss/scripts
    for f in "$CUR_DIR"/scripts/*; do
        if [[ "$(basename "$f")" == 'README.md' || "$(basename "$f")" == 'LICENSE' ]]; then
            continue
        fi
        chmod u+x "$f"
        ln -s "$f" "$BIN/$(basename "$f")"
    done
    echo "Done installing scripts."
}

install_go_stuff() {
    echo "Installing go-related stuff..."
    # fwdl
    go install git.scarlet.house/oss/fwdl@latest

    # mpv-mp
    go install git.scarlet.house/oss/mpv-mp@latest

    # sqlc
    go install github.com/kyleconroy/sqlc/cmd/sqlc@latest

    # migrate
    go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
    echo "Done installing go-related stuff..."
}

init_home
install_packages
install_base
install_scripts
install_go_stuff

echo "Installation is done. You have to set up st, zsh and some other stuff by yourself!"
echo "Don't forget to configure neovim!"

exit 0
