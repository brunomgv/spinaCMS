# Use a slim Ruby image to reduce image size
FROM ruby:3.2.6-slim

# Install dependencies with --no-install-recommends to install only essential packages, and clean up apt cache to reduce image size
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Install bundler separately for better layer caching
RUN gem install bundler -v 2.4.14

# Copy Gemfile and Gemfile.lock first to leverage Docker layer caching
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs=4 --retry=3

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Use ENTRYPOINT for flexibility and CMD for default behavior
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]
CMD ["-p", "3000"]