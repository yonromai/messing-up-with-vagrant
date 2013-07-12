# installing node 

package { "software-properties-common":
  ensure  => present,
  	before => Exec["add-apt-repository ppa:chris-lea/node.js"]
}

package { "python-software-properties":
  ensure  => present,
  before => Exec["add-apt-repository ppa:chris-lea/node.js"]
}

package { "python":
  ensure  => present,
  before => Exec["add-apt-repository ppa:chris-lea/node.js"]
}

package { "g++":
  ensure  => present,
  before => Exec["add-apt-repository ppa:chris-lea/node.js"]
}

package { "make":
  ensure  => present,
  before => Exec["add-apt-repository ppa:chris-lea/node.js"]
}

exec { "add-apt-repository ppa:chris-lea/node.js":
  path => "/usr/bin:/usr/sbin:/bin"
}

exec { "apt-get update":
  path => "/usr/bin:/usr/sbin:/bin",
  require => Exec["add-apt-repository ppa:chris-lea/node.js"]
}

package { "nodejs":
  ensure  => present,
  require => Exec["apt-get update"]
}

package { "git":
  ensure  => present,
  require => Exec["apt-get update"]
}

vcsrepo { "/code/nodebootstrap":
  ensure => present,
  provider => git,
  source => "git://github.com/inadarei/nodebootstrap.git"
}

exec { "npm install supervisor -g":
  cwd => "/code/nodebootstrap",
  path => "/usr/bin:/usr/sbin:/bin",
  require => Vcsrepo["/code/nodebootstrap"],
  before => Exec["npm install"]
}

exec { "npm install forever -g":
  cwd => "/code/nodebootstrap",
  path => "/usr/bin:/usr/sbin:/bin",
  require => Vcsrepo["/code/nodebootstrap"],
  before => Exec["npm install"]
}

exec { "npm install":
  cwd => "/code/nodebootstrap",
  path => "/usr/bin:/usr/sbin:/bin",
  before => Exec["sh start.sh"]
}

exec { "sh start.sh":
  cwd => "/code/nodebootstrap",
  path => "/usr/bin:/usr/sbin:/bin"
}
