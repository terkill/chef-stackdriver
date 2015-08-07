# Cookbook Name:: stackdriver
# Attributes:: default
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

default[:stackdriver][:action] = :upgrade
default[:stackdriver][:api_key] = ''
default[:stackdriver][:config_collectd] = true
default[:stackdriver][:enable] = true
default[:stackdriver][:gen_hostid] = false
default[:stackdriver][:tags] = {}
default[:stackdriver][:gpg_key] = 'https://app.stackdriver.com/RPM-GPG-KEY-stackdriver'

case node[:platform]
when 'amazon'
  if node[:platform_version].to_f > 2012.09
    default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/repo/amzn-2014.03/$basearch/'
  else
    default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/repo/el6/$basearch/'
  end
  default[:stackdriver][:config_path] = '/etc/sysconfig/stackdriver'
when 'centos', 'redhat', 'scientific'
  default[:stackdriver][:repo_url] = "http://repo.stackdriver.com/repo/el#{node['platform_version'].to_i}/$basearch/"
  default[:stackdriver][:config_path] = '/etc/sysconfig/stackdriver'
when 'ubuntu'
  case node[:platform_version].to_i
  when 10, 11
    default[:stackdriver][:repo_dist] = 'lucid'
  when 12, 13
    default[:stackdriver][:repo_dist] = 'precise'
  when 14
    default[:stackdriver][:repo_dist] = 'trusty'
  end
  default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/apt'
  default[:stackdriver][:config_path] = '/etc/default/stackdriver-agent'
when 'debian'
  case node[:platform_version].to_i
  when 6
    default[:stackdriver][:repo_dist] = 'squeeze'
  when 7
    default[:stackdriver][:repo_dist] = 'wheezy'
  when 8
    default[:stackdriver][:repo_dist] = 'jessie'
  end
  default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/apt'
  default[:stackdriver][:config_path] = '/etc/default/stackdriver-agent'
end
