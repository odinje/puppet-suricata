class suricata::params {
  $ensure       = 'present'
  $package_name = 'suricata'
  $config_dir   = '/etc/suricata'

  $service_ensure   = 'running'
  $service_enable   = true
  $service_provider = 'systemd'

  $config_vars = {
    'address-groups' => {
      'HOME_NET'       => '[192.168.0.0/24]',
      'EXTERNAL_NET'   => '!$HOME_NET',
      'HTTP_SERVERS'   => '$HOME_NET',
      'SMTP_SERVERS'   => '$HOME_NET',
      'SQL_SERVERS'    => '$HOME_NET',
      'DNS_SERVERS'    => '$HOME_NET',
      'TELNET_SERVERS' => '$HOME_NET',
      'AIM_SERVERS'    => '$EXTERNAL_NET',
      'DNP3_SERVERS'   => '$HOME_NET',
      'DNP3_CLIENT'    => '$HOME_NET',
      'MODBUS_CLIENT'  => '$HOME_NET',
      'MODBUS_SERVERS' => '$HOME_NET',
      'ENIP_CLIENT'    => '$HOME_NET',
      'ENIP_SERVERS'   => '$HOME_NET'
    },
    'port-groups'     => {
      'HTTP_PORTS'      => '80',
      'SHELLCODE_PORTS' => '!80',
      'ORACLE_PORTS'    => '1521',
      'SSH_PORTS'       => '22',
      'DNP3_PORTS'      => '20000',
      'MODBUS_PORTS'    => '502'
    }
  }
}
