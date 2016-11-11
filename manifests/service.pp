class suricata::service {
  service { 'suricata':
    ensure   => $::suricata::service_ensure,
    enable   => $::suricata::service_enable,
    provider => $::suricata::service_provider,
  }
}
