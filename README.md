# Dotfiles

TODO:  
 - [ ] make this a proper doc  
 - [ ] fasd  
 - [ ] libinput
 - [ ] UL/DL averaging
 - [ ] separate aliases/functions
 - [ ] proper st config/link or find alternative
 - [ ] mail client (mutt)
 - [ ] find the most lightweight functioning graphical web browser (surf)
 - [ ] tmux
 - [ ] Compton
 - [ ] Replace dotbot with Stow
 - [ ] replace execution commands with xdg-open
 - [ ] make dunst not look retarded



| Function | Program      |
|----------:|:-------------|
| Window Manager | [AwesomeWM](awesome), [QTile](qtile)|
| Display Manager | [LightDM](lightdm) |
| Launcher | [rofi](rofi) |
| Web Browser | firefox |
| PDF Viewer | [Zathura](zathurarc) |
| File Manager | [Vifm](file_managers/vifm), [pcmanfm](file_managers/pcmanfm)|
| Text Editor | [Neovim](neovim), leafpad |
| Input | Libinput |
| Terminal Emulator| St |
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