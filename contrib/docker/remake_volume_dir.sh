#!/bin/sh
set -e
set x

#new directory
ckan_config=/raid/system/docker/volumes/docker_ckan_config
ckan_home=/raid/system/docker/volumes/docker_ckan_home
ckan_storage=/raid/system/docker/volumes/docker_ckan_storage
ckan_pg_data=/raid/system/docker/volumes/docker_pg_data

echo "Removing volume contents:"
echo $ckan_config
echo $ckan_home
echo $ckan_storage
echo $ckan_pg_data

rm -rf $ckan_config
rm -rf $ckan_home
rm -rf $ckan_storage
rm -rf $ckan_pg_data

echo "Remaking them"
mkdir -p $ckan_config/_data
mkdir -p $ckan_home/_data
mkdir -p $ckan_storage/_data
mkdir -p $ckan_pg_data/_data
