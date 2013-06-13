#
# Cookbook Name:: mariadb
# Recipe:: default
#
# Copyright (C) 2013 Logan Koester
# 
# All rights reserved - Do Not Redistribute
#

package 'mariadb' do
  action :install
end

package 'libmariadbclient' do
  action :install
end

package 'mariadb-clients' do
  action :install
end

service 'mysqld' do
  provider Chef::Provider::Service::Systemd if node['platform'] == 'arch'
  supports status: true, start: true, stop: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/mysql/my.cnf' do
  mode '0644'
  source 'my.cnf.erb'
end

execute 'Ensure that a root password is set' do
  command "mysql -u root -e 'UPDATE mysql.user SET Password=PASSWORD(\"#{node[:mariadb][:server_root_password]}\") WHERE User=\"root\"; FLUSH PRIVILEGES;'"
  action :run
  only_if "mysql -u root -e 'show databases;'"
end

if node[:mariadb][:remove_anonymous_users]
  execute 'Remove anonymous users' do
    command "mysql -u root --password='#{node[:mariadb][:server_root_password]}' -e \"DELETE FROM mysql.user WHERE User='';\""
  end
end

if node[:mariadb][:remove_test_database]
  execute 'Remove test database and access to it' do
    command "mysql -u root --password='#{node[:mariadb][:server_root_password]}' -e \"DROP DATABASE IF EXISTS test; DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';\""
  end
end
