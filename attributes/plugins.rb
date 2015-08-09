# Cookbook Name:: stackdriver
# Attributes:: plugins
#
# Copyright (C) 2013-2014 TABLE_XI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

default[:stackdriver][:plugins][:conf_dir] = '/opt/stackdriver/collectd/etc/collectd.d/'

default[:stackdriver][:plugins][:apache][:enable] = false
default[:stackdriver][:plugins][:apache][:mod_status_url] = 'http://127.0.0.1/server-status?auto'
default[:stackdriver][:plugins][:apache][:user] = nil
default[:stackdriver][:plugins][:apache][:password] = nil

default[:stackdriver][:plugins][:elasticsearch][:enable] = false
default[:stackdriver][:plugins][:elasticsearch][:http] = 'http://'
default[:stackdriver][:plugins][:elasticsearch][:url] = 'localhost:9200'
default[:stackdriver][:plugins][:elasticsearch][:request_stats] = '/_cluster/nodes/_local/stats?all=true'
default[:stackdriver][:plugins][:elasticsearch][:request_health] = '/_cluster/health'
default[:stackdriver][:plugins][:elasticsearch][:package] =
case node[:platform_family]
when 'debian'
  case node[:platform]
  when 'ubuntu'
    'libyajl1' if node[:platform_version].to_i < 14
  when 'debian'
    'libyajl1' if node[:platform_version].to_i < 7
  end
  'libyajl2'
when 'rhel', 'fedora', 'suse'
  'yajl'
end

default[:stackdriver][:plugins][:nginx][:enable] = false
default[:stackdriver][:plugins][:nginx][:url] = 'http://localhost/nginx_status'
default[:stackdriver][:plugins][:nginx][:username] = false
default[:stackdriver][:plugins][:nginx][:password] = false

default[:stackdriver][:plugins][:redis][:enable] = false
default[:stackdriver][:plugins][:redis][:node] = 'mynode'
default[:stackdriver][:plugins][:redis][:host] = 'localhost'
default[:stackdriver][:plugins][:redis][:port] = '6379'
default[:stackdriver][:plugins][:redis][:timeout] = 2000
default[:stackdriver][:plugins][:redis][:package] =
case node[:platform_family]
when 'debian'
  'libhiredis0.10'
when 'rhel', 'fedora', 'suse'
  'hiredis'
end

default[:stackdriver][:plugins][:mongodb][:enable] = false
default[:stackdriver][:plugins][:mongodb][:host] = 'localhost'
default[:stackdriver][:plugins][:mongodb][:port] = '27017'
default[:stackdriver][:plugins][:mongodb][:username] = false
default[:stackdriver][:plugins][:mongodb][:password] = false
default[:stackdriver][:plugins][:mongodb][:secondary_query] = false

default[:stackdriver][:plugins][:memcached][:enable] = false
default[:stackdriver][:plugins][:memcached][:host] = 'localhost'
default[:stackdriver][:plugins][:memcached][:port] = '11211'
