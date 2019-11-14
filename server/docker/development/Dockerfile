FROM ruby:2.6.5-slim

RUN apt update && apt upgrade -y && apt install -y curl gnupg && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt update  && apt install -y libpq-dev sudo gcc make git patch nodejs postgresql-client yarn graphviz awscli tzdata libmagickwand-dev unzip google-chrome-stable cron cronutils

ARG UID
ARG GID
ARG UNAME

ENV UID ${UID}
ENV GID ${GID}
ENV UNAME ${UNAME}

RUN useradd --uid ${UID} --create-home --shell /bin/bash -G sudo,root ${UNAME}
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV app /home/${UNAME}/myapp
RUN mkdir -p $app
WORKDIR $app
COPY . $app

RUN gem update --system
RUN gem install bundler
RUN bundle update --bundler

RUN bundle install

# Add a script to be executed every time the container starts.
COPY ./server/docker/development/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"]