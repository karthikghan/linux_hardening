#
# Cookbook:: linux_hardening
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

raise ArgumentError,"ERROR: Unsupported Operating system #{node['platform'] }. Please run this cookbook on RHEL systems only!!!" if node['platform_family'] != 'rhel'

#65
service "crond" do
  action [:enable, :start]
end

#66-71
node['linux_hardening']['cron_dirs'].each do |cron_dir|
  directory "/etc/#{cron_dir}" do
    owner 'root'
	group 'root'
	mode '0644'
  end
  end
 
 node['linux_hardening']['cron_files'].each do |cron_file|
  file "/etc/#{cron_file}" do
    owner 'root'
	group 'root'
	mode '0644'
  end
  end
 
#configure cron last point unclear

#sys file permissions firt point unclear

#75-82
node['linux_hardening']['etc_files1'].each do |etc_file1|
  directory "/etc/#{etc_file1}" do
    owner 'root'
	group 'root'
	mode '0644'
  end
  end

node['linux_hardening']['etc_files2'].each do |etc_file2|
  directory "/etc/#{etc_file2}" do
    owner 'root'
	group 'root'
	mode '0000'
  end
  end

#execute 'Ensure root is the only UID 0 account' do
##  command "id root |cut -d'(' -f1 |cut -d'=' -f2"
#  live_stream true
#end

ruby_block "something" do
    block do
        #tricky way to load this Chef::Mixin::ShellOut utilities
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)      
        command = "id root |cut -d'(' -f1 |cut -d'=' -f1"
        command_out = shell_out(command)
        node.normal['my_attribute'] = command_out.stdout
    end
    action :create
end

log "Welcome to Chef, #{node['my_attribute']}!" do
  level :info
end