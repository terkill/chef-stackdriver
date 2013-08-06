name             "stackdriver"
maintainer       "TABLE XI"
maintainer_email "sysadmins@tablexi.com"
license          "GNU Public License 3.0"
description      "Installs/Configures stackdriver agent"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.0"

system "centos"
system "redhat"
system "amazon"
system "ubuntu"

depends "yum"
depends "apt"
