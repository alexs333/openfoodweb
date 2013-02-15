# Open Food Web

Connect suppliers (ie. farmers), distributors (ie. co-ops) and
consumers (ie. local food lovers) for the sale and purchase of local
produce.

## Contributing

If you're interesting in helping out, check out the wiki for more information about the project.

We are using Pivotal Tracker to develop features and you can see (and join in on) what's coming up next at https://www.pivotaltracker.com/projects/709913#

We welcome issues and bugs filed and dealt with on GitHub as well - we'll move them into Pivotal for the core development team as required :)

## Dependencies

* Rails 3.x
* Ruby >= 1.9.2
* PostgreSQL database
* See Gemfile for a list of gems required


## Get it

The source code is managed with Git (a version control system) and
hosted at GitHub.

You can view the code at:

    https://github.com/eaterprises/openfoodweb

You can download the source with the command:

    git clone git@github.com:eaterprises/openfoodweb


## Get it running

For those new to Rails, the following tutorial will help get you up to speed with configuring a Rails environment: http://guides.rubyonrails.org/getting_started.html .

First, check your dependencies: Ensure that you have Ruby 1.9.x installed:

    ruby --version

Install the project's gem dependencies:

    bundle install

Create the development and test databases, using the settings specified in `config/database.yml`. You can then load the schema and some seed data with the following command:

    rake db:schema:load db:seed

At long last, your dreams of spinning up a development server can be realised:

    rails server


## Testing

Tests, both unit and integration, are based on RSpec. To run the test suite, first prepare the test database:

    bundle exec rake db:test:load

Then the tests can be run with:

    bundle exec rspec spec

The site is configured to use
[Spork](https://github.com/sporkrb/spork) to reduce the pre-test
startup time while Rails loads. To use it, first start up a spork
instance:

    bundle exec spork

When that's ready, you can run RSpec with the --drb flag:

    bundle exec rspec --drb spec


## Deployment

Deployment is achieved using [Heroku](http://heroku.com). For access,
speak to Andrew Spinks.


## Credits

* Andrew Spinks (http://github.com/andrewspinks)
* Rohan Mitchell (http://github.com/rohanm)
* Rob Harrington (http://github.com/oeoeaio)


## Licence

Copyright (c) 2012 Open Food Web Foundation, released under the AGPL licence.
