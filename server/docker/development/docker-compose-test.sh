#!/bin/bash

# rails用
# docker container stop $(docker container ls -aq)
# docker container rm $(docker container ls -aq)

# yes | docker system prune --volumes

# docker rmi $(docker images -q) --force

# sudo rm -rf ../../../tmp/
# sudo rm -rf ../../../storage/
# sudo rm -rf ../../../public/assets
# sudo rm -rf ../../../node_modules/

# docker-compose up -d --build

# go client用
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)
docker rmi $(docker images -q -f "dangling=true")
docker volume rm $(docker volume ls -qf dangling=true)
yes | docker network prune
yes | docker volume prune

sudo rm -rf ../../../tmp/
sudo rm -rf ../../../storage/
sudo rm -rf ../../../public/assets
sudo rm -rf ../../../node_modules/

docker images -a | grep "development_go-client" | awk '{print $3}' | xargs docker rmi --force

docker-compose up -d --build