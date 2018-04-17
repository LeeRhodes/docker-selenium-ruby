FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    wget \
    curl \
    zip \
    git \
    openssh-client \
    unzip \
    vim \
    && rm -rf /var/lib/apt/lists/*

#Install Ruby and Cucumber

ARG DEBIAN_FRONTEND=noninteractive

ENV LANG_WHICH en
ENV LANG_WHERE US
ENV ENCODING UTF-8
ENV LANGUAGE ${LANG_WHICH}_${LANG_WHERE}.${ENCODING}
ENV LANG ${LANGUAGE}
# Layer size: small: ~9 MB
# Layer size: small: ~9 MB MB (with --no-install-recommends)
RUN apt -qqy update \
  && apt -qqy --no-install-recommends install \
    language-pack-en \
    tzdata \
    locales \
  && locale-gen ${LANGUAGE} \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt -qyy autoremove \
  && rm -rf /var/lib/apt/lists/* \
  && apt -qyy clean

RUN apt-get update
RUN apt-get install -y ruby2.3 ruby2.3-dev
RUN apt-get install -y imagemagick libmagickwand-dev
RUN apt-get install -y build-essential
RUN apt -qyy clean