gem_package 'mysql2' do
  gem_binary RbConfig::CONFIG['bindir'] + '/gem'
  action :install
end

%w{mariadb libmariadbclient}.each do |pkg|
  package pkg do
    action :install
  end
end

package 'libmariadbclient' do
  action :install
end

package 'mariadb-clients' do
  action :install
end

execute 'Initialize the MariaDB data directory' do
  command 'mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql'
  action :run
  only_if do
    ::Dir['/var/lib/mysql/*'].empty?
  end
end

if node['mariadb']['supervisor']
  supervisor_service 'mysqld' do
    command '/usr/bin/mysqld'
    user 'mysql'
    action [:enable, :start]
  end
else
  service 'mysqld' do
    supports status: true, start: true, stop: true, restart: true, reload: true
    action [:enable, :start]
  end
end

template '/etc/mysql/my.cnf' do
  mode '0644'
  source 'my.cnf.erb'
end

root_password = data_bag_item('database_users', 'root')['password']

execute 'Ensure that a root password is set' do
  command "mysql -u root -e 'UPDATE mysql.user SET Password=PASSWORD(\"#{root_password}\") WHERE User=\"root\"; FLUSH PRIVILEGES;'"
  action :run
  only_if "mysql -u root -e 'show databases;'"
end

if node['mariadb']['remove_anonymous_users']
  execute 'Remove anonymous users' do
    command "mysql -u root --password='#{root_password}' -e \"DELETE FROM mysql.user WHERE User='';\""
  end
end

if node['mariadb']['remove_test_database']
  execute 'Remove test database and access to it' do
    command "mysql -u root --password='#{root_password}' -e \"DROP DATABASE IF EXISTS test; DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';\""
  end
end
