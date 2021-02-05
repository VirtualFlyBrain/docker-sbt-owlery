#!/bin/bash

echo "Loading OWLERY"

## get remote configs
echo "Sourcing remote config"
source ${CONF_DIR}/config.env

cp -v ${CONF_DIR}/application.conf /srv/conf/

sed -i "s|http://www.virtualflybrain.org/owl/vfb.owl|${OWLURL}|g" /srv/conf/application.conf

cat /srv/conf/application.conf

/usr/share/owlery/bin/owlery -Dowlery.port=8080 -Dowlery.host=0.0.0.0 -Dconfig.file=/srv/conf/application.conf
