exec { "apt-update":
	command => "/usr/bin/apt-get update"
}

exec { "build-essential":
	command => "/usr/bin/apt-get install -y build-essential"
}

include apache, php, nodejs, utils