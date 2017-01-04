require 'spec_helper'

describe 'suricata::script', :type => :define do 
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :pre_condition do
        'class { "suricata": }'
      end
      let(:title) { 'stats.lua' }
      let(:facts) do
        facts
      end
      
      context 'with ensure => absent' do
        let(:params) { { 'ensure' => 'absent', 'source' => 'puppet:///modules/suricata/files/stats.lua' } }
        it { should contain_file('/etc/suricata/lua-output/stats.lua').with_ensure('absent') }
      end

    end
  end
end
