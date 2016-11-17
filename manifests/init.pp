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
  String $ensure, # Should probaly regex
  String $package_name,
  String $config_dir,
  String $config_name, 
  String $service_ensure,
  Boolean $service_enable,
  String $service_provider,
  Boolean $manage_user,
  String $user,
  String $group,
  String $user_shell,
  String $bin_path,
  Optional[Array[String]] $interfaces,
  Boolean $base_config_enabled,
  
  Optional[Hash] $config = {},
) {

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
