# My little Elixir/Phoenix to do app

## How to start/host the app

- Clone the repository and start the docker container with `docker-compose up`

- Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## To Hack on your ToDo app:

- Install docker
- Build the docker database `docker-compose up`
- Get all the required dependencies `mix deps.get`

* Setup the project `mix setup`

- Start the phoenix server `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Current Features:

- User Registration and Login
- ToDo list to add and delete entries
