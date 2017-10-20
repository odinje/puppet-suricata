# == Class: suricata
#
# Module to install and configure Suricata IDS
#
# === Parameters
#
# [*ensure*]
#   Choose whether suricata should be present, absent, latest or version
#   Defaults to 'present'
#
# [*package_name*]
#   Name of suricata package in repo
#   Defaults to 'suricata'
#
# [*config_dir*]
#   Directory of configuration files
#   Defaults to '/etc/suricata'
#
# [*config_name*]
#   Name of suricata main configuration
#   Defaults to 'suricata.yaml'
#
# [*log_dir*]
#   Directory of suricatas log files
#   Defaults to '/var/log/suricata'
#
# [*service_ensure*]
#   Choose whether suricata service is running or stopped
#   Defaults to 'running'
#
# [*service_enable*]
#   Choose to enable suricata at startup or not
#   Defaults to true
#
# [*service_provider*]
#   Which service provider suricatas service will use
#   Default depends on os
#
# [*manage_user*]
#   Choose wheter this module will manage the user
#   Defaults to true
#
# [*user*]
#   Name of user that suricata is running as and owner of configuration files
#   Defaults to 'suricata'
#
# [*group*]
#   Name of users group
#   Defaults to 'suricata'
#
# [*user_shell*]
#   Path to user shell
#   Default depends on os
#
# [*bin_path*]
#   Path to suricatas binary file
#   Default depends on os
#
# [*basic_configuration_enabled*]
#   Choose whether to apply the modules included basic configuration
#   Defaults to true
#
# [*configure_epel*]
#  Choose whether this module will install epel from offical repository
#  Default to true if os is RHEL 
#
# [*interfaces*]
#   A string of comma-separated interfaces.
#   Defaults to the first interfaces found in the interface fact
#
# [*cmd_options*]
#   A string of additonal commandline options
#   Defaults to undef
#
# [*main_config*]
#   A hash of suricatas main configuration options.
#
# [*classification_config*]
#   An array of suricatas classification configuration options.
#
# [*reference_config*]
#   An array of suricatas reference configuration options.
#    
# [*threshold_config*]
#   An array of suricatas threshold configuration options.
#

class suricata (
  String $ensure,
  String $package_name,
  Stdlib::Absolutepath $config_dir,
  String $config_name,
  Stdlib::Absolutepath $log_dir,
  Enum['running', 'stopped'] $service_ensure,
  String $service_name,
  Boolean $service_enable,
  String $service_provider,
  Boolean $manage_user,
  String $user,
  String $group,
  Stdlib::Absolutepath $user_shell,
  Stdlib::Absolutepath $bin_path,
  Boolean $basic_configuration_enabled,
  Boolean $configure_epel,
  String $ppa_source,
  Variant[String, Boolean] $interfaces  = split($::interfaces, ',')[0],
  Optional[String] $cmd_options = undef,

    ### START Hiera Lookups ###
  Optional[Hash] $main_config            = {},
  Optional[Array] $classification_config = [],
  Optional[Array] $reference_config      = [],
  Optional[Hash] $threshold_config       = {},
    ### STOP Hiera lookups ###

) {

  if $basic_configuration_enabled {
    $_main_config           = lookup('suricata::basic_main_config', Hash) + $main_config
    $_classification_config = lookup('suricata::basic_classification_config', Array) + $classification_config
    $_reference_config      = lookup('suricata::basic_reference_config', Array) + $reference_config
    $_threshold_config      = $threshold_config
  } else {
    $_main_config           = $main_config
    $_classification_config = $classification_config
    $_reference_config      = $reference_config
    $_threshold_config      = $threshold_config
  }

  contain ::suricata::install
  contain ::suricata::config
  contain ::suricata::service

  Class['::suricata::install']->
  Class['::suricata::config']~>
  Class['::suricata::service']
}
