### Environment setting

`.bashrc` = Executes every time a bash shell is invoked  
`.profile` = Executes when a bash login shell is invoked  
`.xprofile` = Executes at the beginning of the X user session. Sourced by display managers  
`.Xresources` = WIP  

## ZSH

`.zshrc` = Executs every time a zsh shell is invoked  
`.zprofile` = Executes when a zsh login shell is invoked  
`.zimrc` = High-level config for ZIM behaviour  
`zimfw` = Directory where zim code resides  

`.zshrc` -> `$ZIM_HOME/init.zsh` -> `.zimrc`  

`zimfw` directory needs to be pointed to by the `$ZIM_HOME` variable, in `.zprofile`.  

Note: `.profile` and `.zprofile` are symlinked from the same `profile` file.  