#!/usr/bin/env bash
docker build -t bpi-r2 .
export CONTAINER_ID=`docker create bpi-r2`
docker cp $CONTAINER_ID:/opt/bin/targets/mediatek/mt7623 .
docker rm $CONTAINER_ID