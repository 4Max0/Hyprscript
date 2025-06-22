# About this project:

Hyprscript is supposed to be a Hyprland install script. You will be able to install and use Hyprscript, after you install Arch Linux on your device via Archinstall for example.
What Hyprscript does, is that it install Packages and Configs and configures them, so you don't have to install and configure your Hyprland on Arch Linux manually. [More Details here.](#what-is-being-installed)

# How does it Look:

Here are some Preview Pictures to look at:

**Picture of the Desktop:**
![Picture of the Desktop](.doc/2025-05-28-201058_hyprshot.png)

**Picture of the terminal and rofi open:**
![Picture of the terminal and rofi open](.doc/2025-05-28-204303_hyprshot.png)

**Picture of neovim:**
![Picture of neovim](.doc/2025-05-28-204046_hyprshot.png)

The picture was drawn by me, 4Max0, in case you wondered.

# How to install

## Steps:
Install your Arch Linux and git then copy the repository with the following command:

```
git clone https://github.com/4Max0/Hyprscript.git
```

After that move into the directory you cloned of of git:

```
cd Hyprscript
```

Then run the install script:
```
bash install.sh
```

If you're German like me, you can use the '-de' flag to set the Keyboard Layout to 'de':

```
bash install.sh -de
```

If everything worked out don't forget to remove the cloned repository:
```
cd ..
rm -rf Hyprscript
```

## What to do if an error occurs:
The installation script generates a log file called 'logfile.log' in the Hyprscript directory. If you encounter an error, try to open in and look around for errors. Example using everyone favorite editor vim:

```
vim logfile.log
```

# What is being installed:

If you are rightfully paranoid, with what this Project does to your PC, you might want to check the [config files](config-files/) and the [custom settings](custom-settings/) directories.

In the config files directory you wild find a bunch of, guess what, config files. With also a directory called [packages](config-files/packages/), where you can look at all the necessary Pacman and yay packages that are being installed (yes HTop and Fastfetch are necessary if you use Linux).

In similar fashion you will find in the custom-settings directory in two files called [custom_packages.conf](custom-settings/custom_packages.conf) and [yay_custom_packages.conf](custom-settings/yay_custom_packages.conf). In those files you can add or remove packages, if you want before running the script.

Anyways some important components:

**ZSH:**
The Script will change your shell to zsh.
It will install some cool plugins like zsh syntax highlighting, zsh completions and autosuggestions, but also fzf tab completion. 

**TMUX:**
Tmux is going to be installed on the system by running this script.
By typing `tsession` in the terminal you will be able to select a tmux session, if you're not already in one.
If you also have no current session, the script will create one called `default`.

**NVIM:**
Neovim featuring plugins like `telescope`, `nerdtree` and the `kanegawa` theme.
The plugins are being installed and managed by [Lazy Neovim](https://github.com/folke/lazy.nvim).

# Keyboard Config:

The Key Binds are mostly the standard Key Binds, with the 'Super' (Windows Key) being the "mainMod" Bind. Here are some important Binds:

| Keybind                   | Action                                |
|---------------------------|---------------------------------------|
| mainMod + Q               | Opens Alacritty                       |
| mainMod + C               | Kill Window                           |
| mainMod + M               | Exits Hyprland                        |
| mainMod + E               | Open yazi                             |
| mainMod + V               | Floating Mode                         |
| mainMod + R               | Open Rofi                             |
| mainMod + Number          | Change Workspace                      |
| mainMod + Shift + Number  | move Application to Workspace         |
| mainMod + S               | toggle special Workspace              |
| mainMod + Shift + S       | move Application to special Workspace |
| mainMod + left Click      | move Application                      |
| mainMod + right Click     | resize Application                    |
| mainMod + L               | Lock screen                           |
| Print                     | Hyprshot regional Screenshot          |
| mainMod + F               | Application fullscreen mode           |
| mainMod + W               | Change wallpapers you have            |
