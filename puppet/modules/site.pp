include fedora
include autoupdate

# make sure ec2-api-tools are installed for signalling cloudformation
package { 'ec2-api-tools':
	ensure => present,
}

# install fail2ban to keep people from hammering ssh if its open to the world.
package { 'fail2ban':
	ensure => present,
}