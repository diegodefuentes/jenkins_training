#
# Cookbook Name:: apache_softtek
# Spec:: mod_ssl
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'apache_softtek::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
	
	it 'installs ssl' do
	  expect(chef_run).to install_package('Install SSL') 
	end

		
    it 'Modifies ssl.conf' do
	  expect(chef_run).to create_template('/etc/httpd/conf.d/ssl.conf') 
	end	
	
	it 'restart httpd with ssl' do
      template = chef_run.template('/etc/httpd/conf.d/ssl.conf')
      expect(template).to notify('service[Apache]').to(:restart)
    end
  end
end