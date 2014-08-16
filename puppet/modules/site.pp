include fedora
include autoupdate

package { 'ec2-api-tools':
	ensure => present,
}

package { 'fail2ban':
	ensure => present,
}