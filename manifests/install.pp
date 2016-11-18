class suricata::install {

  case $::osfamily {
    'RedHat': {
      $pkg_require = Package['epel-release']

      package { 'epel-release':
        ensure => installed,
      }

    }

    default: { notice("Your operating system: ${::osfamily} is not support") }

  }

  package { $::suricata::package_name:
    ensure  => $::suricata::ensure,
    require => $pkg_require,
  }
}
