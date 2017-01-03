define suricata::script (
  String $ensure = 'present',
  String $name   = $title,
  Pattern[/^puppet/] $source,
) {
}

