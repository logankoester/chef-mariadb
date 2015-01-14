# If enabled, the mysql server will NOT be accessible from the network
default[:mariadb][:skip_networking] = true

# Enabling this feature can make the client initialization longer.
default[:mariadb][:enable_autcomplete] = true

default[:databases] = []
default[:database_users] = []

default[:mariadb][:remove_anonymous_users] = true
default[:mariadb][:remove_test_database] = true

default[:mariadb][:supervisor] = false
