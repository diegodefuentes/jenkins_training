#
# Cookbook Name:: apache_softtek
# Recipe:: debian
#
# Extra configuration files for Apache2 server on Debian and Ubuntu based servers
#
# Copyright (c) 2015 Diego De Fuentes Ceballos,
# Softtek All Rights Reserved.


template "#{node['apache']['appfolder']}/envvars" do
  source 'envvars.erb'
  mode '0644'
  notifies :restart, 'service[Apache]'
end

template "#{node['apache']['appfolder']}/#{node['apache']['extraconf']}/charset.conf" do
  source 'charset.conf.erb'
  mode '0644'
  notifies :restart, 'service[Apache]'
end

template "#{node['apache']['appfolder']}/#{node['apache']['extraconf']}/ports.conf" do
  source 'ports.conf.erb'
  mode '0644'
  notifies :restart, 'service[Apache]'
end

template "#{node['apache']['appfolder']}/#{node['apache']['extraconf']}/security.conf" do
  source 'security.conf.erb'
  mode '0644'
  notifies :restart, 'service[Apache]'
end

template "#{node['apache']['appfolder']}/#{node['apache']['extraconf']}/serve-cgi-bin.conf" do
  source 'serve-cgi-bin.conf.erb'
  mode '0644'
  notifies :restart, 'service[Apache]'
end