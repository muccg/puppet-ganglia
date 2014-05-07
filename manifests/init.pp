class ganglia {

  package { 'ganglia-monitor':
    ensure => installed;
  }

  service { 'ganglia-monitor':
    ensure    => running,
    enable    => true,
    hasstatus => false,
    pattern   => '/usr/sbin/gmond',
    require   => Package["ganglia-monitor"],
    subscribe => File[gmond-conf],
  }
}
