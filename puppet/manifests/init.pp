package { 'tomcat7':
	ensure => present,
}

package { 'ec2-api-tools':
	ensure => present,
}

package { 'fail2ban':
	ensure => present,
}

package { 'unattended-upgrades':
	ensure => present,
}

service { 'tomcat7':
  ensure    => running,
  enable    => true,
  require => Package['tomcat7'],
}

file {'tomcat-authbind-config':
  	path    => '/etc/authbind/byport/80',
  	ensure  => file,
  	mode    => 500,
  	owner => 'tomcat7',
    require => Package['tomcat7'],
  	notify => Service['tomcat7'],
}