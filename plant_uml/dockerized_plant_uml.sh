#!/usr/bin/env bash

cp $1 ./shared_volume
current="$PWD"
pushd ./shared_volume
    MSYS_NO_PATHCONV=1 docker compose run --rm plant-uml-cli  plant_uml.jar $1
    cp *.png $current
    git clean -dfx .
popd
