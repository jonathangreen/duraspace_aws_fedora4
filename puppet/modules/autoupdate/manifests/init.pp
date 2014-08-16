class autoupdate{
	package { 'unattended-upgrades':
		ensure => present,
	}

	file {'unattended-upgrades-config' :
		path	=> '/etc/apt/apt.conf.d/10periodic',
		ensure	=> file,
		source	=> 'puppet:///modules/autoupdate/10periodic',
	}
}