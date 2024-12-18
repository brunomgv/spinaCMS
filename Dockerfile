# Build stage for dependencies
FROM ruby:3.2.6-slim AS builder

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    libvips42 \
    libvips-dev && \
    gem install bundler -v 2.4.14 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4 --retry=3

# Final stage
FROM ruby:3.2.6-slim

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    libpq-dev \
    nodejs \
    yarn \
    imagemagick \
    libvips42 \
    libvips-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . .

ENV RAILS_ENV=development

EXPOSE 3000
ENTRYPOINT ["rails"]
CMD ["server", "-b", "0.0.0.0", "-p", "3000"]