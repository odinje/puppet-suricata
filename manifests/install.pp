class suricata::install {

  case $::osfamily {
    'RedHat': {
      package { 'epel-release':
        ensure => installed,
      }
      package { $::suricata::package_name:
        ensure  => $::suricata::ensure,
        require => Package['epel-release'],
      }
    }
    default: {
      notify { "Your operating system: ${::osfamily} is not supported": }
    }
  }
}
