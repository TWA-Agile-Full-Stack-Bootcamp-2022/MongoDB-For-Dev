#!/bin/bash

# https://docs.mongodb.com/mongodb-shell/
# https://www.mongodb.com/docs/mongodb-shell/
# https://www.mongodb.com/docs/mongodb-shell/connect/
# https://www.digitalocean.com/community/tutorials/how-to-use-the-mongodb-shell
docker exec -it mongodb mongosh "mongodb://localhost:27017" --username root --password example
