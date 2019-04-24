# LightDM

## Display/Login manager

### Using `slick-greeter` greeter for the graphical menu.  

Arch packages: `lightdm`, `slick-greeter`, `moka-icon-theme`, `adapta-maia-theme`
Destination directory: `/etc/lightdm/`  
Login background wallpaper: `/usr/share/backgrounds/main.jpg`  

`display_setup.sh`: Executes whatever is within it right before rendering the login manager.  
`lightdm.conf`: Main lightdm backend config, points to `display_setup.sh`.  
`slick-greeter.conf`: Config for graphical login menu.  

Optional package `lightdm-settings`: limited GUI for configuring `slick-greeter.conf`  