require 'spec_helper'
describe 'suricata' do

  let(:facts) { {
    :osfamily => 'RedHat',

  } }
   
 


  context 'with defaults for all parameters' do
    it { should contain_class('suricata') }
  end

  it { should contain_package('suricata').with_ensure('present') }
  
  it 'should set up /etc/suricata/suricata.yaml as concat resource' do
    expect(subject).to contain_concat('/etc/suricata/suricata.yaml').with(
      'owner' => 'suricata',
      'group' => 'root',
      'mode'  => '0600' 
    )
  end

  #it do
  #  is_expected.to contain_file('/etc/suricata/suricata.yaml').with({
  #    'ensure' => 'present',
  #    'owner'  => 'suricata',
  #    'group'  => 'root',
  #    'mode'   => '0600',
  #    })
  #end 
end
