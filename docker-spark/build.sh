#!/bin/bash

set -e

TAG=3.3.0

build() {
    NAME=$1
    IMAGE=spark-$NAME:$TAG
    cd $([ -z "$2" ] && echo "./$NAME" || echo "$2")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build -t $IMAGE .
    cd -
}

if [ $# -eq 0 ]
  then
    build base
    build master
    build worker
    build history-server
    build submit
  else
    build $1 $2
fi
