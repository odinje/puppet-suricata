class suricata::install {

  case $::osfamily {
    'RedHat': {
      if $::suricata::configure_epel {
        $pkg_require = Package['epel-release']

        package { 'epel-release':
          ensure => installed,
        }
      } else { $pkg_require = false }
    }

    default: {
      $pkg_require = false

      notice("Your operating system: ${::osfamily} is not support")
    }

  }

  package { $::suricata::package_name:
    ensure  => $::suricata::ensure,
    require => $pkg_require,
  }
}
