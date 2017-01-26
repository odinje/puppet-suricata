require 'beaker-rspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  # Configure all nodes in nodeset
    c.before :suite do
    copy_module_to(hosts[0], :source => proj_root, :module_name => 'suricata')
    on hosts[0], puppet('module install puppetlabs-stdlib'), {:acceptable_exit_codes => [0]}
    on hosts[0], puppet('module install puppetlabs-apt'), {:acceptable_exit_codes => [0]}
    end  
end
