#!/bin/bash
#set -e
#set x

echo "Exporting CKAN variables"
VOL_CKAN_HOME=`docker volume inspect docker_ckan_home | jq -c '.[] | .Mountpoint'` 
VOL_CKAN_CONFIG=`docker volume inspect docker_ckan_config | jq -c '.[] | .Mountpoint'`
VOL_CKAN_STORAGE=`docker volume inspect docker_ckan_storage | jq -c '.[] | .Mountpoint'`

echo "Removing quotation marks"
VOL_CKAN_HOME="${VOL_CKAN_HOME%\"}"
export VOL_CKAN_HOME="${VOL_CKAN_HOME#\"}"

VOL_CKAN_CONFIG="${VOL_CKAN_CONFIG%\"}"
export VOL_CKAN_CONFIG="${VOL_CKAN_CONFIG#\"}"

VOL_CKAN_STORAGE="${VOL_CKAN_STORAGE%\"}"
export VOL_CKAN_STORAGE="${VOL_CKAN_STORAGE#\"}"

echo $VOL_CKAN_HOME #/var/lib/docker/volumes/docker_ckan_home/_data
echo $VOL_CKAN_CONFIG #/var/lib/docker/volumes/docker_ckan_config/_data
echo $VOL_CKAN_STORAGE #/var/lib/docker/volumes/docker_ckan_storage/_data

echo "Process completed"

echo "Opening production.ini file in $VOL_CKAN_CONFIG"  
                                                                                                                                                                                                                                                                                                                                                                                                                                                         
sudo gedit $VOL_CKAN_CONFIG/production.ini 
