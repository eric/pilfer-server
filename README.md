# Pilfer Server

Collect and display Ruby line profiles reported from [pilfer][]. Gain insight
into _exactly_ how your code performs on production.

[Pilfer][] uses [rblineprof][] to measure how long each line of code takes to
execute and the number of times it was called. Pilfer Server is a Rails app to
collect these profiles and display them along side of the profiled code.

![Pilfer Profile.png](http://cl.ly/image/2a1d332M2w05/Pilfer%20Profile.png)

Take a look at some [Pilfer profiles collected][bundler-pilfer] on the Bundler
API site.

## Deploy

Deploying your own Pilfer Server to Heroku is simple. Clone the repo, create a
new Heroku app, and push.

```bash
$ git clone https://github.com/eric/pilfer-server
$ cd pilfer-server

$ heroku create bundler-api-pilfer
Creating bundler-api-pilfer... done, region is us
http://bundler-api-pilfer.herokuapp.com/ | git@heroku.com:bundler-api-pilfer.git
Git remote heroku added

$ git push heroku master
$ heroku config:set SECRET_TOKEN=`rake secret`
$ heroku run rake db:setup
```

Visit the new app in a browser to make sure everything's working. Go to the
dashboard and copy the test app's token to send a test report.

```bash
$ curl -H 'Accept: application/json' \
       -H 'Content-Type: application/json' \
       -H 'Authorization: Token token="YOUR_APP_TOKEN"' \
       -d @spec/features/api/support/profile.json \
       http://bundler-api-pilfer.herokuapp.com/api/profiles
```

Refresh the dashboard to see the submitted profile.

## Security

GitHub authentication is used to restrict access to only members belonging to
a given GitHub Organization or Team. If you're profiling an open source app
and want profiles to be publicly accessible, skip down to
[disable security](#disable-security)

[Register a new OAuth application][register] with GitHub. Give it a name and
set both the **Main** and **Callback** URLs to the address of your Pilfer
Server.

![GitHub OAuth Application.png](http://cl.ly/image/2b0Q083J3B2y/GitHub%20OAuth%20Application.png)

Add the OAuth app's **Client ID** and **Client Secret** as environment
variables.

```bash
$ heroku config:set GITHUB_CLIENT_ID=your-client-id GITHUB_CLIENT_SECRET=your-client-secret
```

Access can be restricted to either a GitHub team or an entire organization. To
use a team, find the team's ID by going to the team's organization, click the
_Teams_ tab at the top, click the team, and copy the number at the end of the
URL. Using an organization is as simple as providing its name.

```bash
# Grant access to anyone on the Bundler team (https://github.com/organizations/rubygems/teams/336024)
$ heroku config:set GITHUB_AUTH_TEAM=336024

# Grant access to the entire RubyGems organization
$ heroku config:set GITHUB_AUTH_ORG=rubygems
```

## Disable Security

Providing line profiles of open source applications is an awesome service to
the community. Turn off GitHub authorization by setting the `GITHUB_UNSECURED`
environment variable. This gives anyone who visits the site access to view all
collected line profiles and code.

```bash
$ heroku config:set GITHUB_UNSECURED=true
```

## Submit Profiles

Add the `pilfer` gem to your application and start collecting profiles! Pass
the URL to your Pilfer Server and an app token to `Pilfer::Server`. You can
find a Pilfer Server app token either on the app's page or on the dashboard if
the app has no collected profiles.

![Bundler API App.png](http://cl.ly/image/142T3r233k0L/Bundler%20API%20App.png)

```ruby
require 'pilfer'

reporter = Pilfer::Server.new('https://pilfer.com', 'YOUR_APP_TOKEN')
profiler = Pilfer::Profiler.new(reporter)
profiler.profile('bubble sorting') do
  array = (0..100).to_a.shuffle
  bubble_sort array
end
```

There's a lot more that can be done with the Pilfer gem including filtering
files from reports and a Rack middleware. It's all detailed in
[Pilfer's documentation][pilfer-readme].

## Contributing

Setup Pilfer Server to run locally. Run the test suite to make sure
everything's working as expected.

```bash
$ bundle install --without production
$ cp config/database.example.yml config/database.yml
$ rake db:setup
$ rake db:test:prepare
$ bundle exec rspec
```

SQLite is used by default. Optionally, use PostgreSQL or MySQL by adding the
database's connection information to `config/database.yml` like any other
Rails app.

Start up the server and open [the dashboard][dashboard]. Copy the test app's
token and run the following command to send a test report.

```bash
$ rails server
$ curl -H 'Accept: application/json' \
       -H 'Content-Type: application/json' \
       -H 'Authorization: Token token="xnvbDW2CiGXRThNgGpyvog"' \
       -d @spec/features/api/support/profile.json \
       http://localhost:3000/api/profiles
```

Refresh [the dashboard][dashboard] to see the submitted profile.

## License

The MIT License (MIT)

Copyright (c) 2013 Eric Lindvall and Larry Marburger. See [LICENSE][] for
details.


[rblineprof]:     https://github.com/tmm1/rblineprof
[pilfer]:         https://github.com/eric/pilfer
[pilfer-readme]:  https://github.com/eric/pilfer#readme
[bundler-pilfer]: https://pilfer.herokuapp.com/dashboard
[register]:       https://github.com/settings/applications/new
[dashboard]:      http://localhost:3000/dashboard
[license]:        LICENSE
