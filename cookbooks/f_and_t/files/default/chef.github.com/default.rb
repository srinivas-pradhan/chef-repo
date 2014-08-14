#
# Cookbook Name:: f_and_t
# Recipe:: default
#
# Copyright 2014, spradh02
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
template "/etc/logrotate.conf" do
	source "logrotate.conf.erb"
	variables(
		how_often: "daily",
		keep: "31",
	)
end

# USing pure Ruby for conditionals and iterations
template "/tmp/backends.conf" do
	source "backends.conf.erb"
	mode "0444"
	owner "root"
	group "root"
	variables ({
		:enabled => true,
		:backends => ["10.0.0.10","10.0.0.11","10.0.0.12"]
	})
end

# Install third party software
version = "1.3.9"
bash "install_nginx_from_source" do
	cwd Chef::Config['file_cache_path']
	code <<-EOH
		wget http://nginx.org/download/nginx-#{version}.tar.gz
		tar -zxf nginx-#{version}.tar.gz &&
		cd nginx-#{version} &&
		./configure && make && make Install
	EOH
	not_if "test -f /usr/local/nginx/sbin/nginx"
end

# Remote directory -  Copy files/directories to a node 
# Very helpful recipe when used with roles to distribute files to each node looping over an array

remote directory "/tmp/chef.github.com" do
	files_backup 10
	files_owner "root"
	files_group "root"
	files_mode 00644
	owner "root"
	group "root"
	mode 00755
end
