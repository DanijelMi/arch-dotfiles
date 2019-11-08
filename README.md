# Dotfiles

TODO:  

- [ ] fasd
- [ ] libinput
- [ ] mail client (mutt)
- [ ] tmux
- [ ] replace execution commands with xdg-open
- [ ] make dunst not look retarded
- [ ] Newsboat
- [ ] Neofetch
- [ ] Plank

| Function | Program      |
|----------:|:-------------|
| Window Manager | <s> [AwesomeWM](awesome), [QTile](qtile), [Dwm](dwm), openbox, i3</s>, bspwm|
| Display Manager | startx in .profile |
| Launcher | [rofi](rofi) |
| Web Browser | firefox |
| PDF Viewer | [Zathura](zathurarc) |
| File Manager | [Vifm](file_managers/vifm), [pcmanfm](file_managers/pcmanfm)|
| Text Editor | [Neovim](neovim), leafpad |
| Input | Libinput |
| Terminal Emulator| Alacritty |
| Terminal Multiplexer | Tmux |
| Shell | Zsh with ZIM |
| Screen Lock | i3lock |
| Notification | [Dunst](dunst) |
| Keybinds | [sxhkd](sxhkd) |
| Music | [ncmpcpp](ncmpcpp), [mpd](mpd), mpc
| Image Viewer | [sxiv](sxiv) |
| Calculator | speedcrunch |

To symlink all user-side config files, run:

```bash
 ./install
```

For the exact mappings, see `install.conf.yaml` file.

To install all the necessary programs (+ others I rely on), run ./packages-install.sh
