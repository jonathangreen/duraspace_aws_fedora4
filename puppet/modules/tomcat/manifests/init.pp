class tomcat {
  service { 'tomcat7':
    ensure    => running,
    enable    => true,
    require 	=> Package['tomcat7'],
  }

  file {'tomcat-authbind-config':
    	path    => '/etc/authbind/byport/80',
    	ensure  => file,
    	mode    => 500,
    	owner 	=> 'tomcat7',
      require => Package['tomcat7'],
    	notify 	=> Service['tomcat7'],
  }

  file {'tomcat-defaults' :
  	path	=> 'puppet:///modules/tomcat/tomcat7',
  	ensure	=> file,
  	source	=> 'files/tomcat7',
      require => Package['tomcat7'],
    	notify 	=> Service['tomcat7'],
  }

  file {'tomcat-server-xml' :
  	path	=> 'puppet:///modules/tomcat/server.xml',
  	ensure	=> file,
  	source	=> 'files/server.xml',
      require => Package['tomcat7'],
    	notify 	=> Service['tomcat7'],
  }

  package { 'tomcat7':
    ensure => present,
  }
}