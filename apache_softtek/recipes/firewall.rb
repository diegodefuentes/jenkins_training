#
# Cookbook Name:: apache-softtek
# Recipe:: firewall
#
# Copyright (c) 2015 Diego De Fuentes Ceballos,
# Softtek All Rights Reserved.

include_recipe 'iptables::default'

node['apache']['enabled_firewall_rules'].each do |rule|
  iptables_rule rule do
    action :enable
  end
end