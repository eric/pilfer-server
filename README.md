# Pilfer Server

Look into your ruby with [rblineprof](https://github.com/tmm1/rblineprof/).

## Setup

Setup the app:

    $ bundle install [--without production]
    $ cp config/database.example.yml config/database.yml
    $ rake db:setup

Send a test post:

    $ curl -v -H 'Accept: application/json' \
              -H 'Content-Type: application/json' \
              -H 'Authorization: Token token="4B6dtepsro6v6gcSEy0KgQ"' \
              -d @test/fixtures/profile-payload-1.json \
              http://0.0.0.0:3000/api/v1/profiles

## Deploying

Configure required environment variables:

    GITHUB_CLIENT_ID=<client_id>
    GITHUB_CLIENT_SECRET=<client_secret>

and one of:

    GITHUB_AUTH_ORG=<organization_name>
    GITHUB_AUTH_TEAM=<team_id>

Generate a secret token:

    $ rake secret
    $ heroku config:set SECRET_TOKEN={{your secret token}}
