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
  end

  package 'stackdriver-agent'

  service 'stackdriver-agent' do
    supports :start => true, :stop => true, :status => true, :restart => true, :reload => true
    action :enable
  end

  template '/etc/sysconfig/stackdriver' do
    source 'stackdriver-agent.rhel.erb'
    variables ({
      :api_key => node[:stackdriver][:api_key],
      :collectd => node[:stackdriver][:config_collectd]
    })
    notifies :restart, 'service[stackdriver-agent]', :immediately
  end
end
