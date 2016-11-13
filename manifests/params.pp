class suricata::params {
  $ensure       = 'present'
  $package_name = 'suricata'
  $config_dir   = '/etc/suricata'
  $user         = 'suricata'

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

  $rule_path     = '/etc/suricata/rules'
  $enabled_rules = [
    'app-layer-events.rules',
    'decoder-events.rules',
    'dns-events.rules',
    'http-events.rules',
  ]

  $classification_filename = 'classification.config'
  $reference_filename      = 'reference.config'
  $threshold_filename      = undef

  $log_dir = '/var/log/suricata'

  $stats_enabled   = 'yes'
  $stats_interval  = 8

  $config_output = {
    'fast'       => {
      'enabled'  => 'yes',
      'filename' => 'regular',
      'append'   => 'yes'
    },
    'eve-log'    => {
      'enabled'  => 'yes',
      'filetype' => 'regular',
      'filename' => 'eve.json',
      'types'         => {
        'alert'       => {
          'http'      => 'yes',
          'tls'       => 'yes',
          'ssh'       => 'yes',
          'smtp'      => 'yes',
          'xff'       => {
            'enabled' => 'no',
            'mode'    => 'extra data',
            'deployment'  => 'reverse',
            'header'      => 'X-Forwarded-For'
          },
        },
        'http'       => {
          'extended' => 'yes'
        },
        'dns'      => {
          'query'  => 'yes',
          'answer' => 'yes'
        },
        'tls'        => {
          'extended' => 'yes'
        },
        'files'         => {
          'force-magic' => 'no',
          'force-md5'   => 'no'
        },
        'smtp' => {
        },
        'ssh' => {
        },
        'stats'     => {
          'totals'  => 'yes',
          'threads' => 'no',
          'deltas'  => 'no'
        },
        'flow' => {
        },
      },
    },
    'stats'      => {
      'enabled'  => 'yes',
      'filename' => 'stats.log',
      'totals'   => 'yes',
      'threads'  => 'no'
    }
  }
}
