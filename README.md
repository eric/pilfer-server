# Pilfer Server

Collect and display Ruby line profiles reported from [pilfer][]. Gain insight
into _exactly_ how your code performs on production.

Pilfer uses [rblineprof][] to measure how long each line of code takes to
execute and the number of times it was called. Pilfer Server is a Rails app
to collect these profiles and display them along side of the profiled code.

![Pilfer Profile.png](http://cl.ly/image/2a1d332M2w05/Pilfer%20Profile.png)

Take a look at some [Pilfer profiles collected][bundler-pilfer] on the the
Bundler API site.

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

Visit the new app in your browser, go to the dashboard, and copy the test
app's token to send a test report.

```bash
$ curl -v -H 'Accept: application/json' \
          -H 'Content-Type: application/json' \
          -H 'Authorization: Token token="YOUR_APP_TOKEN"' \
          -d @spec/features/api/support/profile.json \
          http://enigmatic-cliffs-7366.herokuapp.com/api/profiles
```

Refresh the dashboard to see the submitted profile.

## Security

GitHub authentication is used to restrict access to only memebers belonging to
a given GitHub Organization or Team.

_TODO: Document creating a new GitHub application. https://github.com/settings/applications/new_

Configure required environment variables:

    GITHUB_CLIENT_ID=<client_id>
    GITHUB_CLIENT_SECRET=<client_secret>

and one of:

    GITHUB_AUTH_ORG=<organization_name>
    GITHUB_AUTH_TEAM=<team_id>

## Submit Profiles

```ruby
require 'pilfer'

reporter = Pilfer::Server.new('https://pilfer.com', 'YOUR_APP_TOKEN')
profiler = Pilfer::Profiler.new(reporter)
profiler.profile('bubble sorting') do
  array = (0..100).to_a.shuffle
  bubble_sort array
end
```

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
          http://localhost:3000/api/profiles
```

Head to the [dashboard](http://0.0.0.0:3000/dashboard) to see the submitted
profile.


[rblineprof]:     https://github.com/tmm1/rblineprof
[pilfer]:         https://github.com/eric/pilfer
[bundler-pilfer]: https://pilfer.herokuapp.com/dashboard
