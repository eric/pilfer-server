# Pilfer Server

Look into your ruby with [rblineprof](https://github.com/tmm1/rblineprof/).

## Setup

  1. Setup the app:

    ``` bash
    $ bundle install --without production
    $ cp config/database.example.yml config/database.yml
    $ rake db:setup
    ```

  2. Open a browser to [http://0.0.0.0:5000/apps/1](http://0.0.0.0:5000/apps/1),
copy the token, and send a test post filling in `TOKEN` with the copied token:

    ``` bash
    $ curl -v -H 'Accept: application/json' \
              -H 'Content-Type: application/json' \
              -H 'Authorization: Token token="431KJqAg48qqb48ZcCRKyw"' \
              -d @test/fixtures/profile-payload-1.json \
              http://0.0.0.0:5000/api/v1/profiles
    ```

  3. Check the [dashboard](http://0.0.0.0:5000/dashboard) for the submitted
profile.

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
