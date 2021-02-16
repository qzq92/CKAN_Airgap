#!/bin/bash
#set -e
#set x

echo "Removing stopped containers"
docker rm $(docker ps -a -q)

