#!/bin/bash
# Script started by Charles McColm, cr@theworkingcentre.org
# for The Working Centre's Computer Recycling Project
# Installs a bunch of extra software that's useful for our
# Linux Mint XFCE 22 (Wilma) deployments
# Special thanks to Cecylia Bocovich for assistance with automating parts of the script
# https://github.com/cohosh
#
# Just run as ./mint-extras.sh, DO NOT run as sudo ./mint-extras.sh


# set the current directory
currentdir=$(pwd)

# Run updates first as some software may not install unless the system is
# updated
sudo apt update && sudo apt upgrade -y

# Mint already has integrated flatpack support

distro=$(cat /etc/lsb-release | grep CODENAME)

# Install OnlyOffice
onlyoffice=$(dpkg -s onlyoffice-desktopeditors | grep Status)
if [ ! "$onlyoffice" == "Status: install ok installed" ]
	then
		wget -O onlyoffice.deb https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb
		sudo dpkg -i onlyoffice.deb
		sudo apt --fix-broken install -y
	else
		echo "OnlyOffice is already installed"
fi

# install Zoom for conferencing
zoom=$(dpkg -s zoom | grep Status)
if [ ! "$zoom" == "Status: install ok installed" ]
	then
	  echo "Installing Zoom"
	  wget -O zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
	  sudo dpkg -i zoom.deb
	  sudo apt --fix-broken install -y
	else
	  echo "Zoom is already installed"
fi

# install btop, htop, mc, curl, git and build-essential because they're awesome tools
sudo apt install btop htop mc curl git build-essential acpi unzip -y

# Install webp support
sudo apt install webp-pixbuf-loader -y

# Install Steam and some Microsoft Fonts
echo "Installing Steam and MS TTF Fonts"
sudo DEBIAN_FRONTEND=noninteractive apt install steam ttf-mscorefonts-installer -y


# install guvcview and cheese - cheese has issues with some webcams
echo "Installing guvcview"
sudo apt install guvcview cheese -y

# installing VLC
echo "Installing VLC"
sudo apt install vlc -y

# installing msttcorefonts
# 02/06/2022 - added DEBIAN_FRONTEND=noninteractive because I saw a Y/N font prompt on a system I'd stepped away from
echo "Installing msttcorefonts"
sudo DEBIAN_FRONTEND=noninteractive apt install msttcorefonts -y

# Microsoft has gracefully given us some cool opentype fonts, let's install those
# Sadly they're burried in a subdirectory of a subdirectory and not named nicely, so let's do that too
cd $currentdir

if [ ! -e CascadiaCode-2404.23.zip ]
	then
		wget https://github.com/microsoft/cascadia-code/releases/download/v2404.23/CascadiaCode-2404.23.zip
		unzip CascadiaCode-2404.23.zip
		mkdir -p CascadiaCode
		mv $currentdir/ttf/* CascadiaCode
		sudo cp -r CascadiaCode/ /usr/share/fonts/truetype
		rm -rf CascadiaCode/
		rm -rf ttf/
		rm -rf woff2/
		mkdir -p CascadiaCode
		mv $currentdir/otf/static/* CascadiaCode/
		rm -rf otf/
	else
		echo "CascadiaCode already downloaded and unzipped"
fi
sudo cp -r CascadiaCode/ /usr/share/fonts/opentype

# installing gstreamer1.0-plugins-ugly
echo "Installing gstreamer1.0-plugins-ugly"
sudo apt install gstreamer1.0-plugins-ugly -y

# install plugins to allow parole to play movie DVDs
sudo apt install gstreamer1.0-plugins-bad* -y

# installing tuxpaint
echo "Installing tuxpaint"
sudo apt install tuxpaint -y

# installing DVD decryption software
echo "Installing libdvd-pkg"
sudo DEBIAN_FRONTEND=noninteractive apt install libdvd-pkg -y
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure libdvd-pkg

# installing Inkscape
echo "Installing Inkscape"
sudo apt install inkscape -y

# install Krita, as it's handy for artists. Note, this adds lots of KDE dependencies
echo "Installing Krita"
sudo apt install krita -y

# installing handbrake and winff
echo "Installing handbrake and winff"
sudo apt install handbrake winff -y

# installing games
# added icebreaker 10/27/2021
echo "Installing a bunch of games"
sudo apt install lbreakout2 freedroid frozen-bubble kobodeluxe aisleriot gnome-mahjongg pysolfc icebreaker supertux mrrescue marsshooter caveexpress -y

# installing hydrogen drum kit and kits
echo "Installing Hydrogen"
sudo apt install hydrogen hydrogen-drumkits -y

# install audacity
echo "Installing audacity"
sudo apt install audacity -y

# install neofetch
sudo apt install neofetch -y

# install hardinfo cpu-x
sudo apt install hardinfo cpu-x -y

# install more screensavers!
sudo apt install xscreensaver-data-extra -y

# install putty for terminal SSH hackers
sudo apt install putty -y

# install gnome-disk-utility
sudo apt install gnome-disk-utility -y

# install tools to read MacOS formatted drives
sudo apt install hfsprogs hfsplus hfsutils -y

# set up the sensors
sensors=$(dpkg -s lm-sensors | grep Status)
if [ ! "$sensors" == "Status: install ok installed" ]
	then
		echo "Installing lm-sensors"
		sudo apt install lm-sensors -y
		sudo sensors-detect
		sensors > /home/$USER/Desktop/sensors.txt
	else
		echo "Lm-sensors is already installed."
fi

# set VLC to be the default DVD player
# xfconf-query -c thunar-volman -p /autoplay-video-cds/command -s 'vlc dvd://'


# check if this appears to be a laptop and if so install tlp and powertop
if [ -d "/proc/acpi/button/lid" ]; then
	sudo apt install tlp powertop-1.13 -y
	sudo service enable tlp
fi

# remove the old deb files
cd $currentdir

rm onlyoffice.deb zoom.deb phoronix.deb adobe.deb

# Remove uvcdynctrl as it seems to sometimes create enormous (200GB+) log files
sudo apt purge uvcdynctrl -y
sudo apt autoremove -y

# GIMP is not installed in Linux Mint, so let's install it
echo "Installing GIMP..."
sudo apt install gimp -y

# Install Godot for making games
sudo apt install godot3 -y

# Install Tuxtyping for kids
sudo apt install tuxtype -y
