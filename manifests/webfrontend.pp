class ganglia::webfrontend inherits ganglia::server {

  include apache::php5
  
  package { 'ganglia-webfrontend': 
	ensure => installed;
  }

}
