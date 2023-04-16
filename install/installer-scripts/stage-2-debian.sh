#!/bin/bash
set -x

# Preparation for CW Skimmer
dpkg --add-architecture i386
wget -O - https://dl.winehq.org/wine-builds/winehq.key |apt-key add -
echo deb https://dl.winehq.org/wine-builds/debian/ buster main >>  /etc/apt/sources.list
sed -r -i 's/^deb(.*)$/deb\1 contrib/g' /etc/apt/sources.list

apt-get update 
apt-get upgrade

apt-get -y install libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 wine winetricks xfce4 socat pulseaudio pavucontrol innoextract xvfb x11vnc xdotool wget tar supervisor net-tools gnupg2 procps git

