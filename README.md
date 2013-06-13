# Gibson mariadb

## Installation

Using [Berkshelf](http://berkshelf.com/), add the mariadb cookbook to your Berksfile.

```ruby
    cookbook 'mariadb', git: 'git@git.ldk.io:logankoester/gibson.git', rel: 'chef/cookbooks/mariadb', branch: 'master'
```

Then run `berks` to install it.

## Default

An enhanced, drop-in replacement for MySQL.

### Usage

Add `recipe[mariadb::default]` to your run list.

## Attributes

Refer to `attributes/default.rb` for details.

## Development

    # Start an archlinux vm
    cd mariadb
    vagrant up 

    # Edit files...

    # Run again
    vagrant provision 

    # Verify
    vagrant ssh

## Author

Author:: Logan Koester (<logan@logankoester.com>)
