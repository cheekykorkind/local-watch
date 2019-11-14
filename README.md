[한국어](README.kr.md)
[日本語](README.jp.md)
# local watch

# command sequence
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