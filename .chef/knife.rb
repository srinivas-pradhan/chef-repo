# See http://docs.opscode.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "spradh02"
client_key               "#{current_dir}/spradh02.pem"
validation_client_name   "spradh02-validator"
validation_key           "#{current_dir}/spradh02-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/spradh02"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks/"]
cookbook_copyright "spradh02"
cookbook_license "apachev2"
cookbook_email_address "srin64@me.com"
knife[:editor]="vim"
