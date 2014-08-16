class autoupdate{
	# Small class to ensure that Ubuntu automatic updates are enabled. 
	# Gives some peace of mind that security updates are installed automatically.

	package { 'unattended-upgrades':
		ensure => present,
	}

	file {'unattended-upgrades-config' :
		path	=> '/etc/apt/apt.conf.d/10periodic',
		ensure	=> file,
		source	=> 'puppet:///modules/autoupdate/10periodic',
	}
}