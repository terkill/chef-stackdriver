default[:stackdriver][:api_key] = ''
default[:stackdriver][:config_collectd] = true
default[:stackdriver][:gpg_key] = 'https://www.stackdriver.com/RPM-GPG-KEY-stackdriver'
case node[:platform]
when 'amazon'
  default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/stackdriver-amazonlinux.repo'
when 'redhat', 'centos'
  default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/stackdriver.repo'
end