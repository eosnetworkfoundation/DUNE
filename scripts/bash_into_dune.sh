#!/usr/bin/env bash

# pass in container_id as arg or use default value
CONTAINER_ID=${1:-"dune_container"}

docker exec -it $CONTAINER_ID /bin/bash
