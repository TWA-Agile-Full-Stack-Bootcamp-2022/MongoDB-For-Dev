#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd "${SCRIPT_DIR}/.."

mkdir -p db

docker compose up --detach mongo-express
