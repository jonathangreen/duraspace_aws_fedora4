class autoupdate{
	package { 'unattended-upgrades':
		ensure => present,
	}
}