#
# Cookbook Name:: stackdriver
# Recipe:: default
#
# Copyright (C) 2013 TABLE_XI
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
#

raise 'There does not appear to be a repository available for your platform.' unless node[:stackdriver][:repo_url]

case node[:platform]
when 'rhel', 'centos', 'amazon'
  remote_file "/etc/yum.repos.d/stackdriver.repo" do
    source node[:stackdriver][:repo_url]
    only_if { node[:stackdriver][:enable] }
  end

  package 'stackdriver-agent' do
    only_if { node[:stackdriver][:enable] }
  end
when 'ubuntu'
  apt_repository 'stackdriver' do
    uri node[:stackdriver][:repo_url]
    distribution node[:stackdriver][:repo_dist]
    components ['main']
    key 'https://www.stackdriver.com/RPM-GPG-KEY-stackdriver'
    only_if { node[:stackdriver][:enable] }
  end

  package 'stackdriver-agent' do
    response_file 'stackdriver-agent.seed.erb'
    only_if { node[:stackdriver][:enable] }
  end
end

service 'stackdriver-agent' do
  supports :start => true, :stop => true, :status => true, :restart => true, :reload => true
  action (node[:stackdriver][:enable]) ? :enable : :disable
end

template node[:stackdriver][:config_path] do
  source 'stackdriver-agent.erb'
  variables ({
    :api_key => node[:stackdriver][:api_key],
    :collectd => node[:stackdriver][:config_collectd]
  })
  notifies :restart, 'service[stackdriver-agent]', :immediately
  only_if { node[:stackdriver][:enable] }
end
