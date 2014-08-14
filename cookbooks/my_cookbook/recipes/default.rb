#
# Cookbook Name:: my_cookbook
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
ENV['MESSAGE'] = 'Hello from Chef'

execute 'print value of environment variables $MESSAGE' do
  command 'echo $MESSAGE > /tmp/message'
end

# Iteration 2 Setting up env variables
execute 'print value of environment variables $MESSAGE' do
  command 'echo $MESSAGE > /tmp/message'
  environment 'MESSAGE' => 'Hello from the execute resource'
end

# Pass environment variables to execute commands(This can be used to modify /etc/sysctl.conf)
max_mem = node['memory']['total'].to_i * 0.8

execute 'echo max memory value into tmp file' do
  command "echo #{max_mem} > /tmp/max_mem"
end

#Overiding attributes
node.override['my_cookbook']['version'] = '1.5'
execute 'echo the path atrribute' do
  command " echo  #{node['my_cookbook']['version']}"
end

#Search nodes using CHEF search

servers = search(:node, role="upgraded_hosts") #Returns an array

servers.each do |srv|
  log srv.name
end

# Databag usage from requestbin.json -> hooks data bag
hook = data_bag_item('hooks', 'request_bin')
http_request 'callback' do
  url hook['url']
end

# Databag loop over all elements in the databag

search(:hooks,'*:*').each do |hook|
  http_request 'callback' do
    url hook['url']
  end
end

# Platform specific chef
Log.info("Running on CentOS") if node.platform['centos']


# Manage Users Data Bags

