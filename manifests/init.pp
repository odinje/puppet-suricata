# == Class: suricata
#
# Module to install and configure Suricata IDS
#
# === Parameters
#
# 
#
# [*ensure*]
#   Passes to suricata package
#   Defaults to present
#
# [*package_name*]
#   Name of suricata package in repo
#   Default to suricata
#
#
class suricata (
  String $ensure       = $::suricata::params::ensure, # Should probaly regex
  String $package_name = $::suricata::params::package_name, 
  String $config_dir   = $::suricata::params::config_dir,
  Hash $config_vars    = $::suricata::params::config_vars
) inherits suricata::params {
  
  contain suricata::install
  contain suricata::config

  Class['::suricata::install']-> 
  Class['::suricata::config']
}
