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
  String $ensure           = $::suricata::params::ensure, # Should probaly regex
  String $package_name     = $::suricata::params::package_name, 
  String $user             = $::suricata::params::user,
  String $config_dir       = $::suricata::params::config_dir,
  String $service_ensure   = $::suricata::params::service_ensure,
  Boolean $service_enable  = $::suricata::params::service_enable,
  String $service_provider = $::suricata::params::service_provider,
  Hash $config_vars        = $::suricata::params::config_vars
) inherits suricata::params {
  
  contain suricata::install
  contain suricata::config
  contain suricata::service

  Class['::suricata::install']-> 
  Class['::suricata::config']~>
  Class['::suricata::service']
}
