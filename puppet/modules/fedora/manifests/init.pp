class fedora {
  include tomcat
  # This is a small module to install fedora4. In the future it would probably be a good 
  # idea to parameterize it to enable fedora security. So it can spin up a secure instance.

  # The default fedora data dir isn't writeable so we create it here
  file {'fedora-data-dir' :
    ensure  => directory,
    path  => '/var/lib/tomcat7/fcrepo4-data',
    owner   => 'tomcat7',
    group   => 'tomcat7',
    before  => File['fedora-war'],
    require => Package['tomcat7'],
  }

  # deploy the fedora war file.
  file {'fedora-war' :
    path  => '/var/lib/tomcat7/webapps/fcrepo-webapp-4.0.0-beta-01.war',
    ensure  => file,
    source  => 'puppet:///modules/fedora/fcrepo-webapp-4.0.0-beta-01.war',
    owner   => 'tomcat7',
    group   => 'tomcat7',
    notify  => Service['tomcat7'],
  }
}