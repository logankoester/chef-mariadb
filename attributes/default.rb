# If enabled, the mysql server will NOT be accessible from the network?# Should the mysql server be accessible from the network?# Should the mysql server be accessible from the network
default[:mariadb][:skip_networking] = true

# Enabling this feature can make the client initialization longer.
default[:mariadb][:enable_autcomplete] = true

default[:mariadb][:server_root_password] = 'gibson'

default[:mariadb][:remove_anonymous_users] = true
default[:mariadb][:remove_test_database] = true
