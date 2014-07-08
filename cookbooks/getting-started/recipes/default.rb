#
# Cookbook Name:: getting-started
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

include_recipe "apt"
apt_repository "s3tools" do
	url "http://s3tools.org/rep/deb-all"
	components ["stable/"]
	key "http://s3tools.org/repo/deb-all/stable/s3tools.key"
	action :add
end
package "s3cmd"

template "/etc/logrotate.conf" do 
	source "logrotate.conf.erb"
	variables(
		how_often:"daily",
		keep:"31"
	)
end

template "/tmp/backend.conf" do
	mode "0444"
	owner "root"
	group "root"
	variables({
		:enabled => true,
		:backends => ["10.0.0.10","10.0.0.11","10.0.0.12"]
	})
end

ENV['MESSAGE'] = 'Hello from Chef'

execute 'print value of environment variable $MESSAGE' do
	command 'echo $MESSAGE > /tmp/message'
end	

max_mem = node['memory']['total'].to_i * 0.8

execute 'echo max memory value into tmp file' do
	command "echo #{max_mem} > /tmp/max_mem"
end

servers = search(:node, "role:web")
servers.each do |srv|
	log srv.Name
end

hook = data_bag_item('hooks','request_bin')
http_request 'callback' do
	url hook['url']
end























