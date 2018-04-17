FROM ayethin/xenial-ruby:0.0.1

RUN gem install bundler
# avoid warning: Don't run Bundler as root
RUN bundle config --global silence_root_warning 1
# avoid warning: The gift source `git://github.com/dwbutler/logstash-logger.git` uses the `git` protocol, which transmits data without encryption. Disable this warning with `bundle config git.allow_insecure true`, or switch to the `https` protocol to keep your data secure.
RUN bundle config --global git.allow_insecure true

ADD Gemfile* /
RUN bundle install
# set timezone
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone=