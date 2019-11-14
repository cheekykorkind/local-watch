#!/bin/bash
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)

yes | docker system prune --volumes

docker rmi $(docker images -q) --force

# sudo rm -rf ../../../tmp/
# sudo rm -rf ../../../storage/
# sudo rm -rf ../../../public/assets
# sudo rm -rf ../../../node_modules/

docker-compose up -d --build
# http://localhost:3000/
# http://localhost:3000/welcome/index