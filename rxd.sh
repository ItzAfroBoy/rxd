#!/bin/bash
# rxd Copyright (C) 2021 ItzAfroBoy

# Defs + Funcs # 

GITHUB=$HOME/Documents/GitHub
SCRIPTDIR=$(pwd)

check() {
  case $1 in
    "dhcpcd")
      if pacman -Q $1 &>/dev/null; then
        echo $1 is installed
        sleep 1
        echo Activating service
        sleep 1
        if sudo systemctl enable --now dhcpcd.service; then
          echo $1 enabled
          sleep 1
          echo -n "Please enter the network interface name: "
          read interface
          if sudo ip link set $interface up; then
            echo $interface is up
            sleep 1
            echo Rechecking connection...
            sleep 3
            if ping -c 1 8.8.8.8 &>/dev/null; then
              echo Your connection is working
            else
              echo There is still an error
              sleep 1
              echo Try again later
              exit
            fi
          else
            echo There is still an error
            sleep 1
            echo Try again later
            exit
          fi
        else
          echo $1 could not be enabled
          sleep 1
          echo Try again later
          exit
        fi
      else
        sudo pacman -S $1 --noconfirm
        echo $1 has successfully installed
        sleep 1
        echo Activating service
        sleep 1
        if sudo systemctl enable --now dhcpcd.service; then
          echo $1 enabled
          sleep 1
          echo -n "Please enter the network interface name: "
          read interface
          if sudo ip link set $interface up; then
            echo $interface is up
            sleep 1
            echo Rechecking connection...
            sleep 3
            if ping -c 1 8.8.8.8 &>/dev/null; then
              echo Your connection is working
            else
              echo There is still an error
              sleep 1
              echo Try again later
              exit
            fi
          else
            echo There is still an error
            sleep 1
            echo Try again later
            exit
          fi
        else
          echo $1 could not be enabled
          sleep 1
          echo Try again later
          exit
        fi
      fi
      ;;
    "xorg")
      pcheck xorg-bdftopcf xorg-iceauth xorg-mkfontscale xorg-sessreg xorg-setxkbmap xorg-smproxy xorg-x11perf xorg-xauth xorg-xbacklight xorg-xcmsdb xorg-xcursorgen xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xinput xorg-xkbcomp xorg-xkbevd xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients xorg-xmodmap xorg-xpr xorg-xprop xorg-xrandr xorg-xrdb xorg-xrefresh xorg-xset xorg-xsetroot xorg-xvinfo xorg-xwd xorg-xwininfo xorg-xwud
      ;;
    "grub")
      if pacman -Q $1 &>/dev/null; then
        echo $1 is installed
        return 0
      else
        echo $1 is not installed
        return 1
      fi
      ;;
    *)
    ;;
  esac
}

pcheck() {
  if pacman -Q $@ &>/dev/null; then
    if [[ $# == 1 ]]; then
      echo $1 is already installed
    else
      FRS=""
      for i in $@; do
        FRS+="${i}, "
      done
      echo $FRS are already installed
    fi
  else
    sudo pacman -S $@ --noconfirm
    if pacman -Q $@ &>/dev/null; then
      if [[ $# == 1 ]]; then
        echo $1 has successfully installed
      else
        FRS=""
        for i in $@; do
          FRS+="${i}, "
        done
        echo $FRS have been successfully installed
      fi
    else
      if [[ $# == 1 ]]; then
        echo $1 has not successfully installed
        sleep 1
        echo Try again later
      else
        FRS=""
        for i in $@; do
          FRS+="${i}, "
        done
        echo $FRS have not successfully installed
        sleep 1
        echo Try again later
      fi
    fi
  fi
}

ycheck() {
  if yay -Q $@ &>/dev/null; then
    if [[ $# == 1 ]]; then
      echo $1 is already installed
    else
      FRS=""
      for i in $@; do
        FRS+="${i}, "
      done
      echo $FRS are already installed
    fi
  else
    yay -S $@ --noconfirm
    if yay -Q $@ &>/dev/null; then
      if [[ $# == 1 ]]; then
        echo $1 has successfully installed
      else
        FRS=""
        for i in $@; do
          FRS+="${i}, "
        done
        echo $FRS have been successfully installed
      fi
    else
      if [[ $# == 1 ]]; then
        echo $1 has not successfully installed
        sleep 1
        echo Try again later
      else
        FRS=""
        for i in $@; do
          FRS+="${i}, "
        done
        echo $FRS have not successfully installed
        sleep 1
        echo Try again later
      fi
    fi
  fi
}

wmcheck() {
	case $1 in
    "-s" | "--string")
      if wmctrl -m 2>/dev/null | grep -q 'Name'; then
        wmg=$(wmctrl -m | grep 'Name')
        read -a wma <<< $wmg
        wm=${wma[1]}
        echo $wm
      else
        echo No WM
      fi
      ;;
    "-n" | "--number")
      if wmctrl -m 2>/dev/null | grep -q 'Name'; then
        wmg=$(wmctrl -m | grep 'Name')
        read -a wma <<< $wmg
        wm=${wma[1]}
        return 0
      else
        return 1
      fi
      ;;
    *)
      ;;
  esac    
}

dmcheck() {
  case $1 in
    "-s" | "--string")
      if systemctl | grep -q 'Display Manager'; then 
        dmg=$(systemctl | grep 'Display Manager')
        read -a dma <<< $dmg
        dm=${dma[0]}
        echo $dm
      else
        echo No DM
      fi
      ;;
    "-n" | "--number")
      if systemctl | grep -q 'Display Manager'; then
        dmg=$(systemctl | grep 'Display Manager')
        read -a dma <<< $dmg
        dm=${dma[0]}
        return 0
      else
        return 1
      fi
      ;;
    *)
      ;;
  esac
}

# Installer #

echo
cat rxd.txt
cd $HOME
echo
sleep 1
echo Starting...
sleep 1

echo Checking internet connection...
sleep 1
if ping -c 1 8.8.8.8 &>/dev/null; then
  echo You have a working internet connection
else
  echo "You don't have a working internet connection"
  sleep 1
  echo "Checking for dhcpcd..."
  sleep 1
  check dhcpcd
fi
sleep 1

echo Setting up folders...
sleep 1
pcheck xdg-user-dirs
xdg-user-dirs-update
if [[ -e $GITHUB ]]; then
  :
else
  mkdir $GITHUB
  mkdir $HOME/.themes
fi
sleep 1

echo Installing + Configuring Git + GitHub CLI...
sleep 1
pcheck git github-cli
echo Your existing Git settings are:
echo $(git config --global user.name)
echo $(git config --global user.email)
echo -n "Would you like to change them? [Y/n]: "
read gchange
case $gchange in
  "y" | "yes")
    echo -n "Git Name: "
    read gname
    echo -n "Git Emai: "
    read gemail
    git config --global --add user.name $gname
    git config --global --add user.email $gemail
    ;;
  "n" | "no")
    ;;
  *)
    echo -n "Git Name: "
    read gname
    echo -n "Git Email: "
    read gemail
    git config --global --add user.name $gname
    git config --global --add user.email $gemail
    ;;
esac
sleep 1
echo Git is now configured
sleep 1
echo gh will not be used for now
sleep 1

echo Configuring Grub...
sleep 1
cd $GITHUB
if check grub; then
  if [[ -e grub2-themes ]]; then
    echo You have some Grub themes downloaded
    sleep 1
    echo -n 'Would you like to install one? [y/N]: '
    read gt
    case $gt in
      "y" | "yes")
        sudo grub2-themes/install.sh
        echo Grub theme set
        ;;
      "n" | "no")
        ;;
      *)
        ;;
    esac
  else
    git clone https://github.com/vinceliuice/grub2-themes.git
    cd grub2-themes
    sudo ./install.sh
    echo "Grub themes downloaded and set"
  fi
else
  echo As grub is not installed, this step will be skipped
  sleep 1
  echo Your current bootloader has not been touched
fi
cd $HOME
sleep 1

echo Installing yay...
sleep 1
cd $GITHUB
if [[ -e yay ]]; then
  echo Yay is installed
  sleep 1
  echo Checking for installation...
  sleep 1
  if yay -V &>/dev/null; then
    echo All is working
  else
    echo yay will be redownloaded + incase of broken files and then installed
    sleep 1
    sudo rm -r yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    echo yay has successfully installed
  fi
else
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  echo yay has successfully installed
fi
cd $HOME
sleep 1

echo Installing Xorg + apps...
sleep 1
pcheck xorg-server xorg-xinit xorg-twm xorg-xclock xterm mesa
check xorg
sleep 1

echo Installing LightDM...
sleep 1
pcheck lightdm lightdm-webkit2-greeter
ycheck lightdm-webkit-theme-aether
sleep 1
echo LightDM will be activated later
sleep 1

echo Install Virtualbox Guest Additions...
sleep 1
pcheck virtualbox-guest-utils
sleep 1
echo The Guest Additions will be activated later
sleep 1

echo Installing i3...
sleep 1
echo There are 3 versions of i3 to install:
sleep 1
echo 1. i3
echo 2. i3 gaps
echo 3. i3 gaps rounded
sleep 1
echo -n "Which one would you like installed? (1, 2, 3) [3]: "
read i3v
case $i3v in
  "1")
    echo i3 it is...
    sleep 1
    pcheck i3-wm
    ;;
  "2")
    echo i3 gaps it is...
    sleep 1
    pcheck i3-gaps
    ;;
  "3")
    echo i3 gaps rounded it is...
    sleep 1
    ycheck i3-gaps-rounded-git
    ;;
  *)
  echo Defaulting to i3 gaps rounded...
  sleep 1
  ycheck i3-gaps-rounded-git 
  ;;
esac
pcheck i3status i3lock dmenu
sleep 1

echo Installing wmctrl...
sleep 1
pcheck wmctrl
sleep 1

echo Installing Kitty...
sleep 1
pcheck kitty
sleep 1

echo Installing ZSH + OH My ZSH...
sleep 1
pcheck zsh
if [[ -e $HOME/.oh-my-zsh ]]; then
  echo Oh My ZSH is already installed
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
sleep 1

echo Installing Neofetch + fet.sh...
sleep 1
pcheck neofetch
ycheck fet.sh-git
sleep 1

echo Installing Nitrogen...
sleep 1
pcheck nitrogen
sleep 1

echo Installing Wallpapers...
sleep 1
if [[ -e $SCRIPTDIR/walls ]]; then
  echo You already have some wallpapers
  sleep 1
  echo Copying to a more suitable place...
  sudo cp -r $SCRIPTDIR/walls /usr/share/
else
  cd $GITHUB
  git clone https://github.com/ItzAfroBoy/walls.git
  sudo cp -r $SCRIPTDIR/walls /usr/share
  cd $HOME
fi
echo "When selecting the walls folder, select at /usr/share/walls"
echo -n "Would you like to set one now? [y/N]: "
read nitro
case $nitro in
  "y" | "yes")
    if wmcheck -n; then
      nitrogen
    else
      echo There is no WM running so nitrogen cannot be opened at this moment
    fi
    ;;
  "n" | "no")
  ;;
  *)
  ;;
esac
sleep 1


echo Installing Text Editors...
sleep 1
pcheck neovim geany
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sleep 1

echo Installing File Managers...
sleep 1
pcheck ranger thunar
sleep 1

echo Installing LxAppearance...
sleep 1
pcheck lxappearance
sleep 1

echo Installing Ant + Kripton GTK Themes...
sleep 1
cd $GITHUB
git clone https://github.com/EliverLara/Kripton.git
git clone https://github.com/EliverLara/Ant.git
sudo cp -r Kripton Ant $HOME/.themes
echo Themes installed
cd $HOME
sleep 1

echo Installing Paper Icons...
sleep 1
ycheck paper-icon-theme-git
sleep 1

echo Installing Fonts...
sleep 1
pcheck xorg-fonts-misc
ycheck ttf-fira-code ttf-work-sans ttf-spacemono ttf-unifont siji-git
sleep 1

echo Installing Polybar...
sleep 1
ycheck polybar
sleep 1

echo Enabling services...
sudo systemctl enable vboxservice.service sshd.service
if dmcheck -n; then
  dm=$(dmcheck -s)
  echo Disabling $dm...
  sudo systemctl disable $dm
else
  :
fi
sudo systemctl enable lightdm.service
echo The configuring is up to you now
sleep 1
echo -n "Would you like to clean your system up? [y/N]: "
read clean
case $clean in
  "y" | "yes")
    cd $GITHUB
    sudo rm -r yay grub2-themes Kripton Ant
    sudo rm -r $SCRIPTDIR/walls
    sudo pacman -Qtdq | pacman -Rns -
    ;;
  "n" | "no")
    ;;
  *)
    ;;
esac
sleep 1
echo Enjoy your new Arch Linux install
sleep 2
exit