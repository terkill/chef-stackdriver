name             'stackdriver'
maintainer       'TABLE XI'
maintainer_email 'sysadmins@tablexi.com'
license          'GNU Public License 3.0'
description      'Installs/Configures Stackdriver agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.6'

# Cookbook dependancies
%w{ yum apt }.each do |cookbooks|
  depends cookbooks
end

# Operating systems supported
%w{ centos redhat amazon ubuntu }.each do |os|
  supports os
end
