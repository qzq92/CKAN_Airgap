#!/bin/bash
set -e
set x

echo "Purging organization dsta"
curl http://ckan.io:5000/api/action/organization_purge -H "X-CKAN-API-Key:  ca58443e-738e-428d-9fc0-dc751f35ffae" -d '{"id":"dsta"}'"
