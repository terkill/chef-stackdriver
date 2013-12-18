#
# Cookbook Name:: stackdriver
# Recipe:: plugins
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

include_recipe('stackdriver::default')

%w(apache elasticsearch mongodb nginx redis).each do |plugin|
  file "#{node[:stackdriver][:plugins][:conf_dir]}#{plugin}.conf" do
    action :delete
    not_if { node[:stackdriver][:plugins][plugin][:enable] }
    notifies :restart, "service[stackdriver-agent]", :delayed
  end
end

# Apache plugin

template "#{node[:stackdriver][:plugins][:conf_dir]}apache.conf" do
  source "apache-conf.erb"
  variables ({
    :url => node[:stackdriver][:plugins][:apache][:mod_status_url],
    :user => node[:stackdriver][:plugins][:apache][:user],
    :password => node[:stackdriver][:plugins][:apache][:password]
  })
  only_if { node[:stackdriver][:plugins][:apache][:enable] }
  notifies :restart, "service[stackdriver-agent]", :delayed
end

# Elastic Search plugin

package "yajil" do
  only_if { node[:stackdriver][:plugins][:elasticsearch][:enable] }
end

template "#{node[:stackdriver][:plugins][:conf_dir]}elasticsearch.conf" do
  source "elasticsearch.conf.erb"
  variables({
    :url => node[:stackdriver][:plugins][:elasticsearch][:url]
  })
  only_if { node[:stackdriver][:plugins][:elasticsearch][:enable] }
  notifies :restart, "service[stackdriver-agent]", :delayed
end

# MongoDB plugin

template "#{node[:stackdriver][:plugins][:conf_dir]}mongodb.conf" do
  source "mongodb.conf.erb"
  variables({
    :host => node[:stackdriver][:plugins][:mongodb][:host],
    :port => node[:stackdriver][:plugins][:mongodb][:port],
    :username => node[:stackdriver][:plugins][:mongodb][:username],
    :password => node[:stackdriver][:plugins][:mongodb][:password],
    :secondary_query => node[:stackdriver][:plugins][:mongodb][:secondary_query]
  })
  only_if { node[:stackdriver][:plugins][:mongodb][:enable] }
  notifies :restart, "service[stackdriver-agent]", :delayed
end

# Nginx plugin

template "#{node[:stackdriver][:plugins][:conf_dir]}nginx.conf" do
  source "nginx.conf.erb"
  variables({
    :url => node[:stackdriver][:plugins][:nginx][:url],
    :username => node[:stackdriver][:plugins][:nginx][:username],
    :password => node[:stackdriver][:plugins][:nginx][:password]
  })
  only_if { node[:stackdriver][:plugins][:nginx][:enable] }
  notifies :restart, "service[stackdriver-agent]", :delayed
end

# Redis plugin

template "#{node[:stackdriver][:plugins][:conf_dir]}redis.conf" do
  source "redis.conf.erb"
  variables({
    :redis_node => node[:stackdriver][:plugins][:redis][:node],
    :host => node[:stackdriver][:plugins][:redis][:host],
    :port => node[:stackdriver][:plugins][:redis][:port],
    :timeout => node[:stackdriver][:plugins][:redis][:timeout]
  })
  only_if { node[:stackdriver][:plugins][:redis][:enable] }
  notifies :restart, "service[stackdriver-agent]", :delayed
end




