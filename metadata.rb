name             'rails_cookbook'
maintainer       'nclouds.com'
maintainer_email 'jt@nclouds.com'
license          'Apache 2.0'
description      'Installs/Configures rails_cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends "git"
depends "mysql"
depends "ssh_known_hosts"
depends "application_ruby"
depends "database"
