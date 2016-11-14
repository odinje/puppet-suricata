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
  String $ensure                       = $::suricata::params::ensure, # Should probaly regex
  String $package_name                 = $::suricata::params::package_name,
  String $user                         = $::suricata::params::user,
  String $config_dir                   = $::suricata::params::config_dir,
  String $config_name                  = $::suricata::params::config_name, 
  String $service_ensure               = $::suricata::params::service_ensure,
  Boolean $service_enable              = $::suricata::params::service_enable,
  String $service_provider             = $::suricata::params::service_provider,
  Optional[Array[String]] $interfaces  = lookup({'name' => 'suricata::interfaces', 'default_value' => undef}),
  Boolean $base_config_enabled         = true,
  Optional[Hash] $config               = lookup({'name' => 'suricata::config', 'default_value' => undef}),
) inherits suricata::params {

  $base_config   = lookup('suricata::base_config')
  if $base_config_enabled and $config {
    $master_config = merge($base_config, $config)
  } elsif $base_config_enabled and ! $config {
    $master_config = $base_config
  } elsif ! $base_config_enabled and $config {
    $master_config = $config
  } elsif ! $base_config_enabled and ! $config {
    fail("${title}: Add config or enable base config")
  }

  contain suricata::install
  contain suricata::config
  contain suricata::service

  Class['::suricata::install']->
  Class['::suricata::config']~>
  Class['::suricata::service']
}
