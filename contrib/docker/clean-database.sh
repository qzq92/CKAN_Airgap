#!/bin/bash
#set -e
#set x

ADMIN="qzq"
echo "Creating test data with ckan-paster via ckan container" 
docker exec -it ckan /usr/local/bin/ckan-paster --plugin=ckan db clean -c /etc/ckan/production.ini 
