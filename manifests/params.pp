class suricata::params {
  $ensure       = 'present'
  $package_name = 'suricata'
  $config_dir   = '/etc/suricata'
  $config_name  = 'suricata.yaml'
  $user         = 'suricata'

  $service_ensure   = 'running'
  $service_enable   = true
  $service_provider = 'systemd'
  
}
