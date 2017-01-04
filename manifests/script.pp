define suricata::script (
  Pattern[/^puppet/] $source,
  Enum['present','absent'] $ensure = 'present',
  String $script_name   = $title,
) {

  if ! defined(Class['suricata']) {
    fail('You must include the suricata base class before using any suricata defined resources')
  }

  file { "${::suricata::config_dir}/lua-output/${script_name}":
    ensure => $ensure,
    owner  => $::suricata::user,
    group  => 'root',
    mode   => '0600',
    source => $source,
  }
}
