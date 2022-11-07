FROM ruby:3.0.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir -p /domino/api
WORKDIR /domino/api
COPY Gemfile /domino/api/Gemfile
COPY Gemfile.lock /domino/api/Gemfile.lock
RUN bundle install
COPY . /domino/api

ENV ENTRYKIT_VERSION 0.4.0
RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

ENTRYPOINT [ \
  "prehook", "ruby -v", "--", \
  "prehook", "/domino/api/prehook", "--"]
