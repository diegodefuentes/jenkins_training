#
# Cookbook Name:: apache_softtek
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'chefspec'

describe 'include_recipe::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  
  it 'converges successfully' do
      expect { chef_run }.to_not raise_error
  end

  it 'includes SELinux::disabled recipe' do
    expect(chef_run).to include_recipe("selinux::disabled")
  end
  it 'includes the Apache Softtek Server recipe' do
    expect(chef_run).to include_recipe('apache:softtek::server')
  end
  it 'includes the MOD SSL Server recipe' do
    expect(chef_run).to include_recipe('apache:softtek::mod_ssl')
  end
  it 'includes the Firewall recipe' do
    expect(chef_run).to include_recipe('apache:softtek::firewall')
  end
  
end