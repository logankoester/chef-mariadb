include_recipe 'mariadb::install'
include_recipe 'database::mysql'
include_recipe 'mariadb::databases'
include_recipe 'mariadb::database_users'
