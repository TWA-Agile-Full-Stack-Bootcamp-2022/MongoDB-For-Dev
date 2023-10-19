#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd "${SCRIPT_DIR}/.."

docker compose up --detach mongo-express
