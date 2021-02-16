#!/bin/bash
#set -e
#set x

echo "Rebuilding solr indexing" 
docker exec -it ckan_main /usr/local/bin/ckan-paster --plugin=ckan search-index rebuild -c /etc/ckan/production.ini 
