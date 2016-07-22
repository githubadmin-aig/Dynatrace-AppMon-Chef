#
# Cookbook Name:: dynatrace
# Recipes:: chef_provisioning
#
# Copyright 2016, Dynatrace
# for internal purpose; it fix issue related to insufficient ruby version installed on node, instead of execute ruby embedded in chef
# It fix error for:
#    require 'chef/provisioning'
#    with_driver 'ssh'
#

ruby_block "Chef provisioning prepare" do
  block do
    cmd2exec = "ruby -v"
    result = %x[ #{cmd2exec} ]   #ruby 2.0.0p648 (2015-12-16) [x86_64-linux]
    if result =~ /ruby 2.0/
      puts 'Bad ruby version' + result + '. Ruby version should be >= 2.1'
        
      cmd2exec = '/opt/chef/embedded/bin/gem install chef-zero'
      puts "Execute: #{cmd2exec}"
      result = %x[ #{cmd2exec} ]
      puts "result: #{result}"
        
      cmd2exec = '/opt/chef/embedded/bin/gem install chef-provisioning'
      puts "Execute: #{cmd2exec}"
      result = %x[ #{cmd2exec} ]
      puts "result: #{result}"
        
      cmd2exec = '/opt/chef/embedded/bin/gem install chef-provisioning-ssh'
      puts "Execute: #{cmd2exec}"
      result = %x[ #{cmd2exec} ]
      puts "result: #{result}"
    end
  end
#  ignore_failure true
end
