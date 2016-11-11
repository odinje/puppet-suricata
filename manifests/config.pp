class suricata::config {
  
  file { "${::suricata::config_dir}/suricata.yaml":
    ensure  => file,
    owner   => 'suricata',
    group   => 'root',
    mode    => '0600',
    content => template('suricata/suricata.yaml.erb'),
  }
}
