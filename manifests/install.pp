class suricata::install {

  case $::osfamily {
    'RedHat': {
      package { 'suricata':
        ensure  => $::suricata::ensure,
        name    => $::suricata::package_name,
        require => Class['::epel'],
      }
    }
    default: {
      notify { "Your operating system: ${::osfamily} is not supported": }
    }
  }
}
