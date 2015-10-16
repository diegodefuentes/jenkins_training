#
# Cookbook Name:: apache_softtek
# Recipe:: mod_ssl
#
# Copyright (c) 2015 Diego De Fuentes Ceballos,
# Softtek All Rights Reserved.

package 'Install SSL' do
  case node[:platform]
  when 'amazon','redhat', 'centos', 'fedora'
  	package_name 'mod_ssl'
	action :install
  when 'ubuntu', 'debian'
    package_name 'openssl'
	action :install
  end
end

execute 'enable_ssl' do
	command 'a2enmod ssl'
	action :nothing
end

template "#{node['apache']['appfolder']}/#{node['apache']['conffolder']}/ssl.conf" do
  case node[:platform]
  when 'amazon','redhat', 'centos', 'fedora'
  source 'ssl.conf.erb'
  mode '0644'
  when 'ubuntu', 'debian'
  notifies :run, 'execute[enable_ssl]', :immediately
  source 'ssl.conf.erb'
  mode '0644'
  end
  notifies :restart, 'service[Apache]'
end