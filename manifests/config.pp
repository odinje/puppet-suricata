class suricata::config {
  if $::suricata::manage_user {
    user { $::suricata::user:
      ensure  => present,
      system  => true,
      shell   => $::suricata::user_shell,
      gid     => $::suricata::group,
      comment => 'Suricata Open Source IDS / IPS / NSM engine',
      require => Group[$::suricata::group],
    }
    group { $::suricata::group:
      ensure => present,
      system => true,
    }
  }

  concat { "${::suricata::config_dir}/${::suricata::config_name}":
    ensure  => present,
    owner   => $::suricata::user,
    group   => 'root',
    mode    => '0600',
    warn    => true,
    notify  => Service[$::suricata::service_name],
    require => User[$::suricata::user],
  }
  concat::fragment { $::suricata::config_name:
    target  => "${::suricata::config_dir}/${::suricata::config_name}",
    content => $::suricata::master_config.to_yaml,
  }

}
