class tomcat {
  # Small tomcat module. Installs tomcat from apt. 
  # This could be further parameterized so that settings could be passed into it.

  service { 'tomcat7':
    ensure    => running,
    enable    => true,
    require 	=> Package['tomcat7'],
  }

  # Adds a config file to authbind to ensure that tomcat can run as a
  # unprivileged user on port 80.
  file {'tomcat-authbind-config':
  	path    => '/etc/authbind/byport/80',
  	ensure  => file,
  	mode    => 500,
  	owner 	=> 'tomcat7',
    group   => 'tomcat7',
    require => Package['tomcat7'],
  	notify 	=> Service['tomcat7'],
  }

  # Setup tomcat to use authbind. And to enable
  # log zipping and deletion.
  file {'tomcat-defaults' :
  	path	=> '/etc/default/tomcat7',
  	ensure	=> file,
  	source	=> 'puppet:///modules/tomcat/tomcat7',
    owner   => 'tomcat7',
    group   => 'tomcat7',
    require => Package['tomcat7'],
    notify 	=> Service['tomcat7'],
  }

  # Setup tomcat to run on port 80.
  file {'tomcat-server-xml' :
  	path	=> '/etc/tomcat7/server.xml',
  	ensure	=> file,
  	source	=> 'puppet:///modules/tomcat/server.xml',
    owner   => 'tomcat7',
    group   => 'tomcat7',
    require => Package['tomcat7'],
    notify 	=> Service['tomcat7'],
  }

  # make sure the package is installed.
  package { 'tomcat7':
    ensure => present,
  }
}