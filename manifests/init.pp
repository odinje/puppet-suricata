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
  String $service_ensure               = $::suricata::params::service_ensure,
  Boolean $service_enable              = $::suricata::params::service_enable,
  String $service_provider             = $::suricata::params::service_provider,
  Boolean $base_config_enabled         = true,
  Optional[Hash] $config               = lookup({'name' => 'suricata::config', 'default_value' => undef}),
  #Hash $config_vars                    = $::suricata::params::config_vars,
  #Hash $config_output                  = $::suricata::params::config_output,
  #String $rule_path                    = $::suricata::params::rule_path,
  #Array[String] $enabled_rules         = $::suricata::params::enabled_rules,
  #String $classification_filename      = $::suricata::params::classification_filename,
  #String $reference_filename           = $::suricata::params::reference_filename,
  #Optional[String] $threshold_filename = $::suricata::params::threshold_filename,
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
