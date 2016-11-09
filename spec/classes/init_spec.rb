require 'spec_helper'
describe 'suricata' do

  context 'with defaults for all parameters' do
    it { should contain_class('suricata') }
  end
end
