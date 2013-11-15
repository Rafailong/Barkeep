Exec {
	path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
}

exec { "aptgetupdate":
  user => root,
  group => root,
  command => "apt-get update"
}

file {
    'barkeepDirecotry':
    	require => Exec['aptgetupdate'],
        ensure  => directory,
        owner   => 'root',
        path 	=> '/tmp/barkeepDirecotry',
}

exec {
    'downloadBarKeepInstaller':
    require 	=> File['barkeepDirecotry'],
    cwd 		=> '/tmp/barkeepDirecotry',
    command		=> 'wget https://raw.github.com/ooyala/barkeep/master/install_barkeep.sh',
    user 		=> 'root',
    group 		=> 'root',
}

# we cant do this because the base box already have ruby and the intslalation process is 
# asking for permissions
exec {
    'rubBarKeepINstaller':
    	require	 	=> Exec['downloadBarKeepInstaller'],
    	cwd 		=> '/tmp/barkeepDirecotry/',
        command     => 'bash install_barkeep.sh',
        user 		=> 'root',
    	group 		=> 'root',
    	timeout 	=> 0,
}