#
# Cookbook Name:: apache_softtek
# Spec:: server
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
	
	it 'installs httpd' do
	  expect(chef_run).to install_package('Install Apache') 
	end
		
	it 'Enables httpd' do
	  expect(chef_run).to enable_service('Apache') 
	end
	
	it 'Modifies httpd.conf' do
	  expect(chef_run).to create_template('/etc/httpd/conf/httpd.conf') 
	end	

	it 'restart httpd' do
      template = chef_run.template('/etc/httpd/conf/httpd.conf')
      expect(template).to notify('service[Apache]').to(:restart)
    end
	
  end
end