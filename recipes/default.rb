include_recipe 'arch_mariadb::install'
include_recipe 'database::mysql'
include_recipe 'arch_mariadb::databases'
include_recipe 'arch_mariadb::database_users'
