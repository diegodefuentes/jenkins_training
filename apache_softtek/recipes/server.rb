#
# Cookbook Name:: apache_softtek
# Recipe:: server
#
# Copyright (c) 2015 Diego De Fuentes Ceballos,
# Softtek All Rights Reserved.

package 'Install Apache' do
  case node[:platform]
  when 'amazon','redhat', 'centos', 'fedora'
    package_name 'httpd'
  when 'ubuntu', 'debian'
    package_name 'apache2'
  end
  	action :upgrade
end

service 'Apache' do
  case node[:platform]
  when 'amazon','redhat', 'centos', 'fedora'
  	service_name 'httpd'
  when 'ubuntu', 'debian'
    service_name 'apache2'
  end
  action [ :enable ]
end

template "#{node['apache']['appfolder']}/#{node['apache']['conffile']}" do
  source "#{node['apache']['conffile']}.erb"
  mode '0644'
  notifies :restart, 'service[Apache]'
end

  case node[:platform]
  when 'ubuntu', 'debian'
  include_recipe "#{cookbook_name}::debian"
  end