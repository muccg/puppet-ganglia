class ganglia::client inherits ganglia {
  
  $deaf_yesno = "no"
  
  $ganglia_send_metadata_interval = 60
  $ganglia_cluster_name = $ganglia_group

  $ganglia_hosts = ["10.0.0.175"]

  file { 
    gmond-conf:
      path    => "/etc/ganglia/gmond.conf",
      owner   => root,
      group   => root,
      backup  => false,
      mode    => '0644',
      require => Package["ganglia-monitor"],
      content => template("ganglia/gmond.conf.erb");

    "/usr/bin/gmetric":
      require => Package["ganglia-monitor"],
      mode    => '0755';
  }
}
