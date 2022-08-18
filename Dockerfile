# ./Dockerfile

# Extend from the official Elixir image.
FROM elixir:latest
RUN apt-get update && \
    apt-get install -y postgresql-client
RUN apt install bash
# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY . /app
WORKDIR /app
# Install Hex package manager.
# By using `--force`, we don’t need to type “Y” to confirm the installation.
RUN mix local.hex --force
# Compile the project.
RUN mix deps.get
RUN mix local.rebar --force
RUN mix do compile

ENTRYPOINT ["./entrypoint.sh"]