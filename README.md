## Introduction
What started as a simple repo of some basic dotfiles (.bashrc, .xinitrc, .xmonad, etc) has turned into a bootstrapper that not 
only finds appropriately configured dotfiles of mine, but also installs and configures the various components that make my 
useful desktops.
Most of the time that I pull my dotfile repo, it is when I am setting up a fresh system. I realized I should just automate a lot 
more of it.

## Use
```
git clone https://github.com/hon1nbo/dotfiles
cd dotfiles/.scripts/.bootstrap
```
edit common/config file
```
sh bootstrap.sh
```
follow prompts


## Supported Systems
**Arch** is the primary supported system, however other OSes are in the works for the full bootstrapping scripts:
### Supported Systems Goal:
- Arch
- Debian (though not Ubuntu, due to issues with the GPG agent and GNOME as it comes out of the box)
- CentOS / RHEL systems

## License
This project is released under the **MIT** license.
