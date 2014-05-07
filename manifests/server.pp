
class ganglia::server inherits ganglia {

  # are we not listening?
  $deaf_yesno = "no"

  if $ganglia_cluster_name == "" {
  	$ganglia_cluster_name = $nodetype
  }

  # what nodetypes are we listening for in this server
  if $ganglia_clusters == "" {
    $ganglia_clusters = $nodetypes
  }
  $ganglia_send_metadata_interval = 60

  file { 
    gmond-conf:
      path    => "/etc/ganglia/gmond.conf",
      owner   => root,
      group   => root,
      backup  => false,
      mode    => '0755',
      require => Package["ganglia-monitor"],
      content => template("ganglia/gmond-aggregator.conf.erb");

    gmetad-conf:
      path    => "/etc/ganglia/gmetad.conf",
      owner   => root,
      group   => root,
      backup  => false,
      mode    => '0755',
      require => Package["gmetad"],
      content => template("ganglia/gmetad.conf.erb");
  }

  package {'gmetad': 
    ensure => installed,
  }
  
  service { 'gmetad':
    enable    => true,
    ensure    => running,
    hasstatus => false,
    pattern   => '/usr/sbin/gmetad',
    require   => Package['gmetad'],
  }

}
