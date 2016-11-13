require 'spec_helper'
describe 'suricata' do

  let(:facts) { {
    :osfamily => 'RedHat',

  } }
   
 


  context 'with defaults for all parameters' do
    it { should contain_class('suricata') }
  end

  it { should contain_package('suricata').with_ensure('present') }

  it do
    is_expected.to contain_file('/etc/suricata/suricata.yaml').with({
      'ensure' => 'present',
      'owner'  => 'suricata',
      'group'  => 'root',
      'mode'   => '0600',
      })
  end 
end
