#!/bin/bash
#set -e
#set x

ADMIN="user"
echo "Creating CKAN admin user: $ADMIN via ckan container" 
docker exec -it ckan_main /usr/local/bin/ckan-paster --plugin=ckan user -c /etc/ckan/production.ini add $ADMIN
