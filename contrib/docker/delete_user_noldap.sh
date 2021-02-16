#!/bin/bash
set -e

echo "Entering ckan docker container's shell" 
docker exec -it ckan_main /usr/local/bin/ckan-paster --plugin=pylons shell /etc/ckan/production.ini
