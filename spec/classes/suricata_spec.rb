require 'spec_helper'
describe 'suricata' do  

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults for all parameters' do
        it { should contain_class('suricata') }
      end
      
      if facts[:osfamily] == 'RedHat' 
        it { should contain_package('epel-release').with_ensure('installed') }
      end

      it { should contain_package('suricata').with_ensure('present') }
      it { should contain_user('suricata').with(
        'ensure' => 'present',
        'system' => 'true',
        'shell'  => '/sbin/nologin',
        'gid'    => 'suricata',
       )}
      #it 'should set up /etc/suricata/suricata.yaml as concat resource' do
      #  expect(subject).to contain_concat('/etc/suricata/suricata.yaml').with(
      #    'owner' => 'suricata',
      #    'group' => 'root',
      #    'mode'  => '0600' 
      #  )
      #end

      it { should contain_file('/etc/suricata/classification.config').with(
        'ensure' => 'file',
        'owner'  => 'suricata',
        'group'  => 'root',
        'mode'   => '0600'
      ) }
      
      it { should contain_file('/etc/suricata/reference.config').with(
        'ensure' => 'file',
        'owner'  => 'suricata',
        'group'  => 'root',
        'mode'   => '0600'
      ) }


      if facts[:osfamily] == 'RedHat'
        it { should contain_file('/usr/lib/systemd/system/suricata.service').with(
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
        ) }
      end


  it do
    is_expected.to contain_file('/etc/suricata/suricata.yaml').with({
      'ensure' => 'present',
      'owner'  => 'suricata',
      'group'  => 'root',
      'mode'   => '0600',
      })
  end 
    end
  end
end
