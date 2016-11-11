class suricata::config {
  
  user { 'suricata':
    ensure  => present,
    system  => true,
    shell   => '/sbin/nologin',
    gid     => 'suricata',
    comment => 'Suricata Open Source IDS / IPS / NSM engine',
    require => Group['suricata'],
  }
  group { 'suricata':
    ensure => present,
    system => true,
  }

  file { "${::suricata::config_dir}/suricata.yaml":
    ensure  => file,
    owner   => 'suricata',
    group   => 'root',
    mode    => '0600',
    content => epp('suricata/suricata.yaml.epp'),
    notify  => Service['suricata'],
    require => User['suricata'],
  }
}
