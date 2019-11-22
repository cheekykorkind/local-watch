[한국어](README.kr.md)
[日本語](README.jp.md)
# local watch

# set up command sequence
- `cd server/docker/development/`

- If you do not set .env file, execute.
  - `sh setDotEnv.sh`

- `docker-compose up -d --build`

- If you do not have db, execute.
  - `docker exec web bundle exec rails db:create`
  - `docker exec web bundle exec rails db:migrate`

- `docker-compose run web rails generate controller Welcome index`
- `docker attach web`
- If you finish debug, execute.
  - remove `byebug` in your code
  - at console input and enter : `exit`
  - at console press : `Ctrl+P` and `Ctrl+Q`

## go client
- `docker exec -it go-client /bin/sh`
- `go run linux_memory.go`

### build binary(cross-compile, CentOS)
- `go build -a -ldflags "-linkmode external -extldflags '-static' -s -w" linux_memory.go`
- `cd ./go-client/workspace && ./linux_memory`
- `cd /home/jiho/private_work/local-watch/server/docker/development/ && sh docker-compose-test.sh`