# sxhkd - Simple X HotKey Daemon  

## Manages most of the system keybinds

### Although some keybinds are managed by desktops/window managers
The goal is to have keybinds that work cross-desktop/window manager environments.  

Use the `xorg-xev` package to find out key codes.

To autostart, add following line in .xinitrc (AND/OR in .profile ... TOFIX);
`sxhkd &`
