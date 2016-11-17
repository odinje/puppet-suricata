class suricata::install {

  case $::osfamily {
    'RedHat': {
      package { 'epel-release':
        ensure => installed,
      }
      package { 'suricata':
        ensure  => $::suricata::ensure,
        name    => $::suricata::package_name,
        require => Package['epel-release'],
      }
    }
    default: {
      notify { "Your operating system: ${::osfamily} is not supported": }
    }
  }
}
