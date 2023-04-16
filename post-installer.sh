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


git clone https://github.com/8cH9azbsFifZ/docker-cwskimmer.git



cd /root/

V_NOVNC=1.1.0
V_WEBSOCKIFY=0.9.0
wget -O - https://github.com/novnc/noVNC/archive/v${V_NOVNC}.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-${V_NOVNC} /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html
wget -O - https://github.com/novnc/websockify/archive/v${V_WEBSOCKIFY}.tar.gz | tar -xzv -C /root/ && mv /root/websockify-${V_WEBSOCKIFY} /root/novnc/utils/websockify
# Configure window title
cat /root/novnc/vnc_lite.html | sed 's/<title>noVNC/<title>CW Skimmer/g' > /root/novnc/tmp.html && cat /root/novnc/tmp.html > /root/novnc/vnc_lite.html && rm /root/novnc/tmp.html



V_HERMES=21.7.18
V_SKIMMER=2.1
V_SKIMMERSRV=1.6
V_RBNAGGREGATOR=6.3

# Copy installation files and extract them
INSTALLDIR=/root/docker-cwskimmer/install/
mkdir -p /skimmer_1.9
cd /skimmer_1.9
unzip $INSTALLDIR/Skimmer_1.9/CwSkimmer.zip 
innoextract Setup.exe

mkdir -p /skimmer_${V_SKIMMER}
cd /skimmer_${V_SKIMMER}
unzip $INSTALLDIR/Skimmer_${V_SKIMMER}/CwSkimmer.zip
innoextract Setup.exe

mkdir -p /skimmersrv_${V_SKIMMERSRV}
cd /skimmersrv_${V_SKIMMERSRV}
unzip $INSTALLDIR/SkimmerSrv_${V_SKIMMERSRV}/SkimSrv.zip 
innoextract Setup.exe

mkdir -p /rbnaggregator_${V_RBNAGGREGATOR}
cd /rbnaggregator_${V_RBNAGGREGATOR}
unzip "$INSTALLDIR/RBNAggregator/Aggregator v${V_RBNAGGREGATOR}.zip"


mkdir -p /HermesDLL_${V_HERMES}
cd /HermesDLL_${V_HERMES}
unzip $INSTALLDIR/HermesDLL/HermesIntf-${V_HERMES}.zip



# XFCE config
cp /root/docker-cwskimmer/config/xfce4 /root/.config/xfce4
# Add startup stuff
cp /root/docker-cwskimmer/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
cp /root/docker-cwskimmer/config/startup.sh /bin
cp /root/docker-cwskimmer/config/startup_sound.sh /bin

