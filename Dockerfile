FROM ruby:2.2.3

WORKDIR /app
ADD Gemfile Gemfile.lock .ruby-version /app/
RUN bundle install
COPY . /app

CMD rackup --port $PORT --host 0.0.0.0
