class suricata::service {
  service { 'suricata':
    ensure   => $::suricata::service_ensure,
    enable   => $::suricata::service_enable,
    provider => $::suricata::service_provider,
  }

  file { '/usr/lib/systemd/system/suricata.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0655',
    content => epp('suricata/suricata.service.epp'),
    notify  => [Exec['Daemon-reload'], Service['suricata']],
    before  => Service['suricata'],
  }

  exec { 'Daemon-reload':
    command => '/bin/systemctl daemon-reload',
    before  => Service['suricata'],
  }
}
