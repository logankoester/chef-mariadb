# If enabled, the mysql server will NOT be accessible from the network
default['mariadb']['skip_networking'] = true

# Enabling this feature can make the client initialization longer.
default['mariadb']['enable_autcomplete'] = true

default['databases'] = []
default['database_users'] = []

default['mariadb']['remove_anonymous_users'] = true
default['mariadb']['remove_test_database'] = true

default['mariadb']['supervisor'] = false

# http://www.percona.com/blog/2008/05/31/dns-achilles-heel-mysql-installation/
default['mariadb']['skip_name_resolve'] = false
default['mariadb']['bind-address'] = '127.0.0.1'
