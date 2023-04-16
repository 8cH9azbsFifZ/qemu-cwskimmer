
# CW Skimmer installation


# Configuration stuff
PATH_INI_SKIMSRV="/root/prefix32/drive_c/users/root/Application Data/Afreet/Products/SkimSrv"
PATH_INI_AGGREGATOR="/rbnaggregator_${V_RBNAGGREGATOR}"
mkdir -p "$PATH_INI_SKIMSRV"
mkdir -p "$PATH_INI_AGGREGATOR"
cp /root/docker-cwskimmer/config/rbn/Aggregator.ini "${PATH_INI_AGGREGATOR}"
cp /root/docker-cwskimmer/config/skimsrv/SkimSrv.ini "${PATH_INI_SKIMSRV}"
cp /HermesDLL_${V_HERMES}/HermesIntf.dll /skimmersrv_${V_SKIMMERSRV}/app/
rm /skimmersrv_${V_SKIMMERSRV}/app/Qs1rIntf.dll
cp /root/docker-cwskimmer/install/patt3ch/patt3ch.lst /skimmersrv_${V_SKIMMERSRV}/userappdata/Afreet/Reference/Patt3Ch.lst

LOGFILE_HERMES=/root/HermesIntf_log_file.txt
LOGIFLE_AGGREGATOR=/root/AggregatorLog.txt



## Configuration
QTH=KA12aa
NAME="Mr. X"
SQUARE=KA12aa

V_HERMES=21.7.18
V_SKIMMER=2.1
V_SKIMMERSRV=1.6
V_RBNAGGREGATOR=6.3


# Startup
# FIXME - alterantive?
echo "Configure Skimmer with Callsign: $CALLSIGN, QTH: $QTH, Name: $NAME, Grid: $SQUARE using $PATH_INI_SKIMSRV"
sed -i 's/Call=/Call='$CALLSIGN'/g' "$PATH_INI_SKIMSRV"/SkimSrv.ini
sed -i 's/QTH=/QTH='$QTH'/g' "$PATH_INI_SKIMSRV"/SkimSrv.ini
sed -i 's/Name=/Name='$NAME'/g' "$PATH_INI_SKIMSRV"/SkimSrv.ini
sed -i 's/Square=/Square='$SQUARE'/g' "$PATH_INI_SKIMSRV"/SkimSrv.ini


echo "Configure RBN Aggregator with Callsign: $CALLSIGN using $PATH_INI_AGGREGATOR"
#sed -i 's/Skimmer Call=.*/Skimmer Call='$CALLSIGN'/g' "$PATH_INI_AGGREGATOR"
#cat "$PATH_INI_AGGREGATOR"
sed -i 's/CW0SKIM/'$CALLSIGN'/g' "$PATH_INI_AGGREGATOR"/Aggregator.ini
#cat "$PATH_INI_AGGREGATOR"
# FIXME: only debug stuff
cp "$PATH_INI_AGGREGATOR"/Aggregator.ini /root/
chmod oag-r "$PATH_INI_AGGREGATOR"/Aggregator.ini

IP_HERMES=127.0.0.1
echo "Configure Hermes DLL for ${IP_HERMES}"
cp /HermesDLL_${V_HERMES}/HermesIntf.dll /skimmersrv_${V_SKIMMERSRV}/app/HermesIntf_${IP_HERMES}.dll



echo "Configure supervisor for aggregator ${V_RBNAGGREGATOR}"
sed -i 's/6\.3/'$V_RBNAGGREGATOR'/g' /etc/supervisor/conf.d/supervisord.conf

echo "Configure supervisor for skimmer ${V_SKIMMERSRV}"
sed -i 's/1\.6/'$V_SKIMMERSRV'/g' /etc/supervisor/conf.d/supervisord.conf




LOGFILE_HERMES=/root/HermesIntf_log_file.txt
LOGIFLE_AGGREGATOR=/root/AggregatorLog.txt


echo "Start using logfiles $LOGFILE_HERMES and $LOGIFLE_AGGREGATOR"
touch $LOGFILE_HERMES
touch $LOGIFLE_AGGREGATOR


/usr/bin/supervisord
