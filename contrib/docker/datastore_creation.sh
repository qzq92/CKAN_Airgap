#!/bin/bash
#set -e
#set x

#echo "Create datastore database and database readonly user in db container.It should have been created when building image"
#docker exec -it db_ckan sh /docker-entrypoint-initdb.d/00_create_datastore.sh

echo "Setting permissions directly and list permissions for user ckan in PSQL.Effect is persisted in the name volume docker_pg_data"
docker exec ckan_main /usr/local/bin/ckan-paster --plugin=ckan datastore set-permissions -c /etc/ckan/production.ini | docker exec -i db_ckan psql -U ckan
echo "Process completed"
