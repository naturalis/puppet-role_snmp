require 'spec_helper'
describe 'role_snmp' do

  context 'with defaults for all parameters' do
    it { should contain_class('role_snmp') }
  end
end
