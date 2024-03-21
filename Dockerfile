# Use the official Ruby image as the base image
FROM ruby:2.7.4

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Set the environment variables
ENV RAILS_ENV=production
ENV DATABASE_URL=postgres://postgres:password@db:5432/myapp_production

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]