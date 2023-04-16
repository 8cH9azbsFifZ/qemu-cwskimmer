#!/bin/bash
set -x

cp config/bash/bash_profile > ~/.bash_profile

wget -O - https://github.com/novnc/noVNC/archive/v${V_NOVNC}.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-${V_NOVNC} /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html
wget -O - https://github.com/novnc/websockify/archive/v${V_WEBSOCKIFY}.tar.gz | tar -xzv -C /root/ && mv /root/websockify-${V_WEBSOCKIFY} /root/novnc/utils/websockify
# Configure window title
cat /root/novnc/vnc_lite.html | sed 's/<title>noVNC/<title>CW Skimmer/g' > /root/novnc/tmp.html && cat /root/novnc/tmp.html > /root/novnc/vnc_lite.html && rm /root/novnc/tmp.html





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

