#!/bin/bash
if [[ $type == "manager" ]]
then
  echo "Starting manager..."
  apt-mirror
fi
if [[ $type == "worker" ]]
then
  echo "Starting worker..."
  apachectl -D FOREGROUND
fi
echo "Missing type..."
exit 1

