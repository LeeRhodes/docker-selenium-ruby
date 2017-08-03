FROM openjdk:8-jdk

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    wget \
    curl \
    zip \
    openssh-client \
    unzip \
    && rm -rf /var/lib/apt/lists/*

#Install Ruby and Cucumber

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y ruby2.3 ruby2.3-dev
RUN apt-get install -y imagemagick libmagickwand-dev
RUN apt-get install -y nodejs
RUN apt-get install -y git
RUN apt-get install -y build-essential
RUN apt-get clean

RUN gem install bundler

# avoid warning: Don't run Bundler as root
RUN bundle config --global silence_root_warning 1

# avoid warning: The gift source `git://github.com/dwbutler/logstash-logger.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
RUN bundle config --global git.allow_insecure true

ADD Gemfile* /
RUN bundle install

# set timezone
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# set env variables
ENV FF_VERSION="40.0.3"

USER root

# install libs, xvfb and firefox
RUN apt-get update && apt-get install -y zlib1g-dev xvfb libxcomposite1 libasound2 libdbus-glib-1-2 libgtk2.0-0
RUN wget "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FF_VERSION}/linux-x86_64/en-US/firefox-${FF_VERSION}.tar.bz2" \
    -O /tmp/firefox.tar.bz2 && \
    tar xvf /tmp/firefox.tar.bz2 -C /opt && \
    ln -s /opt/firefox/firefox /usr/bin/firefox

EXPOSE 465
