require 'spec_helper'

describe 'apache_softtek::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  it 'web site' do
    expect(port 80).to be_listening 'tcp'
  end
  
    it 'web site' do
    expect(port 443).to be_listening 'tcp'
  end
end
