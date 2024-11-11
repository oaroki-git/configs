#!/bin/bash
echo moving configs and installing software from dnf.. \(destructive\)
sudo dnf install git hyprland hyprpaper hyprlock alacritty dolphin neovim waybar openssl openssl-devel
git clone https://github.com/oaroki-git/configs.git
cd configs
mv hypr ~/.config
mv alacritty ~/.config
mv waybar ~/.config
mv wofi ~/.config
mv nvim ~/.config
mv ~/.config/alacritty/starship.toml ~/.config/

echo installing rust and starship
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -sS https://starship.rs/install.sh | sh

echo installing nushell and initializing starship
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

echo !notes\nhyprpaper and hyprlock have images set that are not on this machine\nalso install Hanken Grotesk, azukifont, and commitmono nerdfont or edit the configs to display text properly
