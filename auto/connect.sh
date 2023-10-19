#!/bin/bash

# Warning: the "mongo" shell has been superseded by "mongosh", which delivers improved usability and compatibility.The "mongo" shell has been deprecated and will be removed in an upcoming release. For installation instructions, see https://docs.mongodb.com/mongodb-shell/install/
# docker exec -it mongodb mongo admin -u root -p 'example'


# https://docs.mongodb.com/mongodb-shell/
# https://www.mongodb.com/docs/mongodb-shell/
# https://www.mongodb.com/docs/mongodb-shell/connect/
# https://www.digitalocean.com/community/tutorials/how-to-use-the-mongodb-shell
docker exec -it mongodb mongosh "mongodb://localhost:27017" --username root --password example
