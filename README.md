# Twitter Trends

[![Circle CI](https://circleci.com/gh/matthewjamesr/twitter-trends.svg?style=shield)](https://circleci.com/gh/matthewjamesr/twitter-trends) [![Code Climate](https://codeclimate.com/repos/5600fbfb69568059ab000491/badges/ec23f91f11a93e4ab919/gpa.svg)](https://codeclimate.com/repos/5600fbfb69568059ab000491/feed)

The fast and easy way to see trending users and hashtags relating to a given search.

## Setup

After cloning the repo/making sure postgress is installed:

* bundle install
* rake db:setup
* Create .env file and obtain Twitter API key. Use as documented in the files below:
  * See initializers/api_methods.rb
  * See initializers/omniauth.rb
* Next, rake test. Not green? Most likely a DB or ENV issue.
* rails s

## Contributing

Create a new issue with the proposed feature/branch name, then clone/branch. When
ready commit/push changes and send a pull request.
