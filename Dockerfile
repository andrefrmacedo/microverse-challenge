FROM ruby:3.1
RUN apt-get update && apt-get install -y nodejs postgresql-client

WORKDIR /app
COPY Gemfile* .
RUN bundle install

COPY . .
EXPOSE 3000
