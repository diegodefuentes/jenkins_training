#
# Cookbook Name:: trapache
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'apache2' do
  action :install
end

service 'apache2' do
  action [:enable, :start]
end

template '/var/www/html/index2.html' do
  source 'index2.html.erb'
  action :create
end

