class suricata::config {

  if $::suricata::manage_user {
    $usr_require = User[$::suricata::user]

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
  } else { $usr_require = undef }

  file { [$::suricata::config_dir, "${::suricata::config_dir}/rules", $::suricata::log_dir]:
    ensure  => directory,
    owner   => $::suricata::user,
    group   => 'root',
    mode    => '0750',
    require => $usr_require,
    before  => Concat["${::suricata::config_dir}/${::suricata::config_name}"],
  }

  concat { "${::suricata::config_dir}/${::suricata::config_name}":
    ensure  => present,
    owner   => $::suricata::user,
    group   => 'root',
    mode    => '0600',
    warn    => true,
    notify  => Service[$::suricata::service_name],
    require => $usr_require,
  }
  concat::fragment { $::suricata::config_name:
    target  => "${::suricata::config_dir}/${::suricata::config_name}",
    content => $::suricata::master_config.to_yaml,
  }

  file { "${::suricata::config_dir}/classification.config":
    ensure  => file,
    owner   => $::suricata::user,
    group   => 'root',
    mode    => '0600',
    content => epp('suricata/classification.config.epp'),
    require => $usr_require,
  }

  file { "${::suricata::config_dir}/reference.config":
    ensure  => file,
    owner   => $::suricata::user,
    group   => 'root',
    mode    => '0600',
    content => epp('suricata/reference.config.epp'),
    require => $usr_require,
  }


}
