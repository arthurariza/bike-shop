FROM ruby:3.4.1

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock to cache Gem installs
COPY ./Gemfile ./Gemfile
COPY ./Gemfile.lock ./Gemfile.lock

# Install gems
RUN bundle install

# Copy the rest of the application code to the container
COPY . .

# Make sure the entrypoint script has execute permissions
RUN chmod +x ./docker-entrypoint.sh

# Set the entry point script for Docker
ENTRYPOINT ["./docker-entrypoint.sh"]

# Default command to start the Rails server
CMD [ "bin/rails", "s", "-b", "0.0.0.0" ]
