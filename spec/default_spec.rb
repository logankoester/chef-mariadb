require 'spec_helper'

describe 'mariadb::default' do
  before do
    Fauxhai.mock(path: 'spec/fixtures/arch.json') do |node|
    end
    stub_data_bag('databases').and_return(['default'])
    stub_data_bag('database_users').and_return(['root', 'default'])
    stub_data_bag_item_from_file 'databases', 'default'
    stub_data_bag_item_from_file 'database_users', 'root'
    stub_data_bag_item_from_file 'database_users', 'default'
    stub_command("mysql -u root -e 'show databases;'").and_return ''
  end

  context 'with no databases' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        set_attributes_for node
        node.set['databases'] = []
        node.set['database_users'] = []
      end.converge(described_recipe)
    end

    it 'should install mariadb and related packages' do
      expect(chef_run).to install_package 'mariadb'
      expect(chef_run).to install_package 'libmariadbclient'
      expect(chef_run).to install_package 'mariadb-clients'
    end

  end

  context 'with one database' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        set_attributes_for node
        node.set['databases'] = ['default']
        node.set['database_users'] = ['default']
      end.converge(described_recipe)
    end

    it 'should create the default database' do
      expect(chef_run).to create_mysql_database 'default_db'
    end

    it 'should create the default database user' do
      expect(chef_run).to create_mysql_database_user 'default_user'
    end

    it 'should grant privileges to the default database user' do
      expect(chef_run).to grant_mysql_database_user 'default_user'
    end

  end
end
