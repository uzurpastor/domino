FROM ruby:3.0.0

# Register Yarn package source.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install additional packages.
RUN apt update -qq
RUN apt install -y postgresql-client nodejs yarn

# Prepare working directory.
WORKDIR /domino/api
COPY ./api /domino/api
RUN gem install bundler
RUN bundle install

# Configure endpoint.
COPY ./.docker/api.entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/api.entrypoint.sh
ENTRYPOINT ["api.entrypoint.sh"]
EXPOSE 3000

# Start app server.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]