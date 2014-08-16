class fedora {
	include tomcat

	file {'fedora-data-dir' :
		ensure	=> directory,
		path 	=> '/var/lib/tomcat7/fcrepo4-data',
		owner   => 'tomcat7',
		group   => 'tomcat7',
		before	=> fedora-war
	}

	file {'fedora-war' :
		path	=> '/var/lib/tomcat7/webapps/fcrepo-webapp-4.0.0-beta-01.war',
		ensure	=> file,
		source	=> 'puppet:///modules/fedora/fcrepo-webapp-4.0.0-beta-01.war',
		owner   => 'tomcat7',
		group   => 'tomcat7',
		notify 	=> Service['tomcat7'],
	}
}