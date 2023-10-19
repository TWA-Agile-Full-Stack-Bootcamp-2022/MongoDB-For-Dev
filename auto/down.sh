#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd "${SCRIPT_DIR}/.."

docker compose down --remove-orphans
