#
# Cookbook Name:: rails_cookbook
# Recipe:: default
#
# Copyright (C) 2013 nclouds.com
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "git"
include_recipe "mysql"
include_recipe "mysql::server"
include_recipe "mysql::ruby"
mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => 'rootpass'}

package "sqlite-devel" do
  action :install
end

ssh_known_hosts_entry 'github.com'

group "demo" do
  gid 505
  action :create # see actions section below
end
user "demo" do
  uid 505
  gid 505
  action :create # see actions section below
end

mysql_database 'demo' do
  connection mysql_connection_info
  action :create
end
mysql_database_user 'demo' do
  connection mysql_connection_info
  password 'awesome_password'
  action :create
end

application "demo.nclouds.com" do
  path "/usr/local/www/demo"
  owner "demo"
  group "demo"
  deploy_key node['demo']['deploy_key']
  repository 'git@github.com:jtgiri/rails_base.git'
  revision "HEAD"
  rails do
    gems ['bundler']
    database do
      database "demo"
      username "demo"
      password "awesome_password"
    end
  end
  passenger_apache2 do
  end
end
