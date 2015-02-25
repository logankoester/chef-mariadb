root_password = data_bag_item('database_users', 'root')['password']
mysql_connection_info = {
  host: 'localhost',
  username: 'root',
  password: root_password
}

data_bag('database_users').each do |database_user_id|
  next unless node['database_users'].include? database_user_id
  database_user = data_bag_item 'database_users', database_user_id

  mysql_database_user database_user['username'] do
    connection mysql_connection_info
    password database_user['password']
    host database_user['host'] || 'localhost'
    if database_user['username'] == 'root'
      action :create, :grant
    else
      action :create
    end
  end
end

data_bag('databases').each do |database_id|
  next unless node['databases'].include? database_id
  database = data_bag_item 'databases', database_id

  database['users'].each do |user_id, privileges|
    user = data_bag_item 'database_users', user_id

    mysql_database_user user['username'] do
      connection mysql_connection_info
      database_name database['name']
      host user['host']
      privileges privileges.map { |p| p.to_sym }
      action :grant
    end
  end
end
