class suricata::service {
  
  case $::suricata::service_provider {
    'systemd': {
      $service_require = File['/usr/lib/systemd/system/suricata.service']

      file { '/usr/lib/systemd/system/suricata.service':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp('suricata/suricata.service.epp'),
      }

      exec { 'Daemon-reload':
        command     => '/bin/systemctl daemon-reload',
        subscribe   => File['/usr/lib/systemd/system/suricata.service'],
        refreshonly => true,
        notify      => Service[$::suricata::service_name],
      }
    }
    default: { notice("Your ${::suricata::service_provider} is not supported") }
  }

  service { $::suricata::service_name:
    ensure   => $::suricata::service_ensure,
    enable   => $::suricata::service_enable,
    provider => $::suricata::service_provider,
    require  => $service_require,
  }

}
