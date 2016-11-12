class suricata::service {
  service { 'suricata':
    ensure   => $::suricata::service_ensure,
    enable   => $::suricata::service_enable,
    provider => $::suricata::service_provider,
    require  => File['/usr/lib/systemd/system/suricata.service'],
  }

  file { '/usr/lib/systemd/system/suricata.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('suricata/suricata.service.epp'),
  }~>
  exec { 'Daemon-reload':
    command => '/bin/systemctl daemon-reload',
    notify  => Service['suricata'],
  }
}
