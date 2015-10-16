#
# Cookbook Name:: apache_softtek
# Recipe:: default
#
# Copyright (c) 2015 Diego De Fuentes Ceballos,
# Softtek All Rights Reserved.

include_recipe "#{cookbook_name}::server"
include_recipe "#{cookbook_name}::mod_ssl"
include_recipe "#{cookbook_name}::firewall"