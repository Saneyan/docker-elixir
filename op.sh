#!/bin/sh

cmd=$1

if [[ $cmd == 'run' ]]; then
  name=$2
  container=$3
  opts="-it -d --name $name -u saneyan -e HOME=/home/saneyan -e LANG=en_US.UTF-8 -w /home/saneyan ${@:4}"
  docker run $opts $container
elif [[ $cmd == 'exec' ]]; then
  name=$2
  docker exec -it $name bash
else
  echo 'run|exec'
fi
