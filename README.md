# MariaDB cookbook

> A Chef cookbook for MariaDB (MySQL implementation). Tested on Arch Linux.

## Installation

Using [Berkshelf](http://berkshelf.com/), add the mariadb cookbook to your Berksfile.

```ruby
cookbook 'mariadb', github: 'logankoester/chef-mariadb', branch: 'master'
```

Then run `berks` to install it.

## Default

An enhanced, drop-in replacement for MySQL.

### Usage

Add `recipe[mariadb::default]` to your run list.

## Attributes

Refer to `attributes/default.rb` for details.

## Author

Author:: Logan Koester (<logan@logankoester.com>)
