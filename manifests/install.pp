class suricata::install {

  case $::osfamily {
    'RedHat': {
      package { 'suricata':
        ensure => $::suricata::ensure,
        name   => $::suricata::package_name,
      }
    }
    default: {
      notify { "Your operating system: ${::osfamily} is not supported": }
    }
  }
}
