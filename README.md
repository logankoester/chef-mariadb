# MariaDB cookbook

> A Chef cookbook for installing MariaDB and creating databases and database users from data bags.

[![Build Status](http://ci.ldk.io/logankoester/chef-mariadb/badge)](http://ci.ldk.io/logankoester/chef-mariadb/)
[![Gittip](http://img.shields.io/gittip/logankoester.png)](https://www.gittip.com/logankoester/)

[MariaDB](https://mariadb.org/) is an enhanced, drop-in replacement for MySQL.

## Installation

Using [Berkshelf](http://berkshelf.com/), add the mariadb cookbook to your Berksfile.

```ruby
cookbook 'mariadb', github: 'logankoester/chef-mariadb', branch: 'master'
```

Then run `berks` to install it.

## Usage

Add `recipe[mariadb::default]` to your run list. This recipe will install `mariadb`,
enable and start the mysql service. It's configuration file (`my.cnf`) is installed
from a template. Databases and users will be set up from data bags you create.

### Database users

Create a `database_users` data bag, with an item called `root`. This is
your root database user:

```json
{
  "id": "root",
  "username": "root",
  "password": "SET A SECURE ROOT PASSWORD!"
}
```

You can also create additional database_user items if you wish.

### Databases

Create a `databases` data bag. Items should look like this:

```json
{
  "id": "some_database",
  "name": "some_database",
  "users": {
    "some_database_user": ["all"]
  }
}
```

The `users` property maps items from the `database_users` data bag to an array
of privileges which should be granted.

## Attributes

Refer to `attributes/default.rb` for details.

## Running the tests

This cookbook uses the [Foodcritic](http://www.foodcritic.io/) linter, [ChefSpec](http://sethvargo.github.io/chefspec/) for unit testing, and [ServerSpec](http://serverspec.org/) for integration testing via [Test Kitchen](http://kitchen.ci/) with the [kitchen-docker](https://github.com/portertech/kitchen-docker) driver.

It's not as complicated as it sounds, but you will need to have Docker installed.

1. `git clone git@github.com:logankoester/chef-website.git`
2. `cd chef-website`
3. `bundle install`
4. `bundle exec rake`

This will run all of the tests once. While developing, run `bundle exec guard start` and the relevant tests will run automatically when you save a file.

## Author

Copyright (c) 2014-2015 [Logan Koester](http://logankoester.com). Released under the MIT license. See `LICENSE` for details.
