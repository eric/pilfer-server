# Pilfer Server

Collect and display Ruby line profiles using
[rblineprof](https://github.com/tmm1/rblineprof) and
[pilfer](https://github.com/eric/pilfer). Gain insight into _exactly_ how your
applications perform on production.

Pilfer Server is a Rails app consisting of an API endpoint to collect line
profiles and a handful of views to display them along side of the profiled
code.

_TODO: Insert screenshots and link to bundler-api's profiles._

## Deploy

Deploying your own Pilfer Server to Heroku is simple.

Clone the repo.

```bash
$ git clone https://github.com/eric/pilfer-server
$ cd pilfer-server
```

Create and push to a new Heroku app.

```bash
$ heroku create
Creating enigmatic-cliffs-7366... done, region is us
http://enigmatic-cliffs-7366.herokuapp.com/ | git@heroku.com:enigmatic-cliffs-7366.git
Git remote heroku added

$ git push heroku master
$ heroku config:set SECRET_TOKEN=`rake secret`
$ heroku run rake db:setup
```

Start up the server, open [the dashboard](http://localhost:3000/dashboard),
copy the test app's token, and send a test report.

```bash
$ rails server
$ curl -v -H 'Accept: application/json' \
          -H 'Content-Type: application/json' \
          -H 'Authorization: Token token="YOUR_APP_TOKEN"' \
          -d @test/fixtures/profile-payload-1.json \
          http://localhost:3000/api/v1/profiles
```

Refresh [the dashboard](http://0.0.0.0:3000/dashboard) to see the submitted
profile.

_Add github creds_

Configure required environment variables:

    GITHUB_CLIENT_ID=<client_id>
    GITHUB_CLIENT_SECRET=<client_secret>

and one of:

    GITHUB_AUTH_ORG=<organization_name>
    GITHUB_AUTH_TEAM=<team_id>


## Contributing

Setup Pilfer Server to run locally.

```bash
$ bundle install --without production
$ cp config/database.example.yml config/database.yml
$ rake db:setup
$ rake db:test:prepare
```

SQLite is used by default. Optionally, use PostgreSQL or MySQL by adding the
database's connection information to `config/database.yml`.

Start up the server, open [the dashboard](http://localhost:3000/dashboard),
copy the test app's token, and send a test report.

```bash
$ rails server
$ curl -v -H 'Accept: application/json' \
          -H 'Content-Type: application/json' \
          -H 'Authorization: Token token="YOUR_APP_TOKEN"' \
          -d @spec/features/api/support/profile.json \
          http://localhost:3000/api/v1/profiles
```

Head to the [dashboard](http://0.0.0.0:3000/dashboard) to see the submitted
profile.
