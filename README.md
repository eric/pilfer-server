# Pilfer Server

Look into your ruby with [rblineprof](https://github.com/tmm1/rblineprof/).

## Setup

Configure required environment variables:

    GITHUB_CLIENT_ID=<client_id>
    GITHUB_CLIENT_SECRET=<client_secret>

and one of:

    GITHUB_AUTH_ORG=<organization_name>
    GITHUB_AUTH_TEAM=<team_id>

Later on:

    rake secret # to generate a secret token
    heroku config:set SECRET_TOKEN={{your secret token}}