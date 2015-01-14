require 'spec_helper'

describe package('mariadb') do
  it { should be_installed }
end

describe package('libmariadbclient') do
  it { should be_installed }
end

describe package('mariadb-clients') do
  it { should be_installed }
end

describe service('mysqld') do
  it { should be_running }
end

describe file('/etc/mysql/my.cnf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end
