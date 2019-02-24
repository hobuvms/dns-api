FROM ruby:2.3.3

RUN apt-get update -qq && \
    apt-get install -y redis-server

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["puma", "-w", "5"]
