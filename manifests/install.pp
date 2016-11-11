class suricata::install {

  case $::osfamily {
    'RedHat': {
      include ::epel
      package { 'suricata':
        ensure  => $::suricata::ensure,
        name    => $::suricata::package_name,
        requrie => ::epel
      }
    }
    default: {
      notify { "Your operating system: ${::osfamily} is not supported": }
    }
  }
}
