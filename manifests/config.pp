class suricata::config {

  user { $::suricata::user:
    ensure  => present,
    system  => true,
    shell   => $::suricata::user_shell,
    gid     => 'suricata',
    comment => 'Suricata Open Source IDS / IPS / NSM engine',
    require => Group['suricata'],
  }
  group { 'suricata':
    ensure => present,
    system => true,
  }

  concat { "${::suricata::config_dir}/${::suricata::config_name}":
    ensure  => present,
    owner   => $::suricata::user,
    group   => 'root',
    mode    => '0600',
    warn    => true,
    notify  => Service['suricata'],
    require => User[$::suricata::user],
  }
  concat::fragment { "suricata.yaml":
    target  => "${::suricata::config_dir}/${::suricata::config_name}",
    content => $::suricata::master_config.to_yaml,
  }

}
