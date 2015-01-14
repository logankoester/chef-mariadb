root_password = data_bag_item('database_users', 'root')['password']
mysql_connection_info = {
  host: 'localhost',
  username: 'root',
  password: root_password
}

data_bag('databases').each do |database_id|
  next unless node['databases'].include? database_id
  database = data_bag_item 'databases', database_id

  mysql_database database['name'] do
    connection mysql_connection_info
    action :create
  end
end
