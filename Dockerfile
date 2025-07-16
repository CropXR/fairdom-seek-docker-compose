FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get install -y \
    curl wget git build-essential libssl-dev libreadline-dev zlib1g-dev \
    libxml2-dev libxslt1-dev libmysqlclient-dev libmagickwand-dev \
    libsqlite3-dev sqlite3 mysql-client redis-tools nodejs npm \
    openjdk-11-jdk libreoffice poppler-utils python3 python3-pip \
    locales tzdata libpq-dev postgresql-client libgit2-dev cmake pkg-config libclang-dev libyaml-dev libssh2-1-dev && \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv && \
    echo 'export PATH="/root/.rbenv/bin:$PATH"' >> /root/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> /root/.bashrc && \
    git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build

ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"

RUN rbenv install 3.1.7 && \
    rbenv global 3.1.7 && \
    rbenv rehash

RUN gem install bundler

RUN mkdir -p /seek
WORKDIR /seek

RUN groupadd -r seek && useradd -r -g seek seek

RUN mkdir -p /seek/filestore /seek/log /seek/tmp /seek/config/initializers/custom && \
    chown -R seek:seek /seek

RUN git clone https://github.com/seek4science/seek.git /seek/src && \
    cd /seek/src && \
    git checkout v1.16.2

RUN cp -r /seek/src/* /seek/ && \
    rm -rf /seek/src

RUN npm install -g yarn

COPY database.yml /seek/config/database.yml

RUN bundle install --retry=3

RUN yarn install --production

RUN RAILS_ENV=production bundle exec rake assets:precompile || true

COPY start.sh /seek/start.sh
COPY worker.sh /seek/worker.sh

RUN chmod +x /seek/start.sh /seek/worker.sh

RUN chown -R seek:seek /seek

# Keep running as root for rbenv access
# USER seek

EXPOSE 3000

CMD ["/seek/start.sh"]