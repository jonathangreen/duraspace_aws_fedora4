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
  	path	=> '/etc/default/tomcat7',
  	ensure	=> file,
  	source	=> 'puppet:///modules/tomcat/tomcat7',
      require => Package['tomcat7'],
    	notify 	=> Service['tomcat7'],
  }

  file {'tomcat-server-xml' :
  	path	=> '/etc/tomcat7/server.xml',
  	ensure	=> file,
  	source	=> 'puppet:///modules/tomcat/server.xml',
      require => Package['tomcat7'],
    	notify 	=> Service['tomcat7'],
  }

  package { 'tomcat7':
    ensure => present,
  }
}