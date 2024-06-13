#!/bin/bash

# mint-extras.sh - install extra software useful for general computer use
# created by: chaslinux@gmail.com

# Do not run this script as root or sudo, it will run sudo on the commands 
# it needs to.

# This script was created as part of a move away from Xubuntu to Linux Mint
# XFCE. 

# Update the software repositories and the system
sudo apt update && sudo apt upgrade -y

# Install a few code essentials
sudo apt install git build-essential curl -y

# Install btop
sudo apt install btop -y


# Install phoronix-test-suite for testing, and for extensive system information
# make a directory to put github projects in, then clone the
# phoronix-test-suite repository to it

echo "Making a ~/Code directory to hold our Github projects..."
mkdir ~/Code
cd ~/Code
echo "*** Cloning the phoronix-test-suite repository ***"
git clone https://github.com/phoronix-test-suite/phoronix-test-suite.git
cd phoronix-test-suite
# Install the php dependencies first
echo "*** Install the PHP dependencies for phoronix ***"
sudo apt install php-cli php-xml php-gd php-bz2 php-sqlite3 php-curl -y
# run the phoronix install script
sudo ./install-sh
echo "*** phoronix-test-suite should now be installed ***"
# now go back to the ~/Code directory for other projects
cd ~/Code

# Install more system information
sudo apt install cpu-x hardinfo -y

# Install software for communicating with others
sudo flatpak install com.discordapp.Discord zoom -y

# Install graphics software
sudo flatpak install org.kde.krita org.kde.krita.Codecs -y
sudo flatpak install org.gimp.GIMP org.gimp.GIMP.Manual org.gimp.GIMP.Plugin.GMic/x86_64/2-40 -y
# Install some GIMP plugins
sudo flatpak install org.gimp.GIMP.Plugin.Resynthesizer/x86_64/2-40 -y
sudo flatpak install org.gabmus.swatch -y

# Install webcam software, vector drawing software, and 3D graphics software
sudo apt install guvcview cheese -y
sudo apt install inkscape -y
sudo flatpak install org.blender.Blender -y

# The following are for managing photographs
sudo flatpak install darktable -y
sudo flatpak install rawtherapee -y
sudo apt install rapid-photo-downloader -y
sudo flatpak install com.xnview.XnViewMP -y
sudo flatpak install org.kde.digikam -y
# sudo apt install showfoto -y ## KDE App so a lot of dependencies


# Install multimedia software
sudo apt install vlc smplayer -y
sudo flatpak install com.spotify.Client -y

# Install Game software
sudo apt install steam -y

# Install software to manage documents
sudo flatpak install org.onlyoffice.desktopeditors com.calibre_ebook.calibre -y
sudo apt install qtqr -y

# Install software development stuff
sudo apt install godot3 -y

