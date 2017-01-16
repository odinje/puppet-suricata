class suricata::install {

  case $::osfamily {
    'RedHat': {
      if $::suricata::configure_epel {
        $pkg_require = Package['epel-release']

        package { 'epel-release':
          ensure => installed,
        }
      } else { $pkg_require = undef }
    }
    'Debian': {
      if $::operatingsystem == 'ubuntu' {
        if $::suricata::ppa_source {
          $pkg_require = Apt::Ppa[$::suricata::ppa_source]

          include ::apt
          apt::ppa { $::suricata::ppa_source: }
        }
      } else { $pkg_require = undef }
    }
    default: {
      $pkg_require = undef

      notice("Your operating system: ${::osfamily} is not support")
    }

  }

  package { $::suricata::package_name:
    ensure  => $::suricata::ensure,
    require => $pkg_require,
  }
}
