#!/bin/sh
set -e
set x

echo "Docker exec into ckan container"
docker exec ckan_main /bin/bash -c "export TERM=xterm;paster --plugin=ckan jobs worker --config=/etc/ckan/production.ini"


