class suricata::config {

  user { $::suricata::user:
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

  concat { "${::suricata::config_dir}/suricata.yaml":
    ensure  => present,
    owner   => $::suricata::user,
    group   => 'root',
    mode    => '0600',
    notify  => Service['suricata'],
    require => User['suricata'],
  }
  
  concat::fragment { "suricata.yaml_header":
    target  => "${::suricata::config_dir}/suricata.yaml",
    content => '#MANAGED BY PUPPET\n\n',
    order   => '01',
  }
  concat::fragment { "YAML_version_header_hack":
    target  => "${::suricata::config_dir}/suricata.yaml",
    content => '%YAML 1.1\n',
    order   => '02',
  }
  concat::fragment { "suricata.yaml":
    target  => "${::suricata::config_dir}/suricata.yaml",
    content => $::suricata::config.to_yaml,
    order   => '03',
  }

}
