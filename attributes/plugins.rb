default[:stackdriver][:plugins][:conf_dir] = "/opt/stackdriver/collectd/etc/collectd.d/"

default[:stackdriver][:plugins][:elasticsearch][:enable] = false
default[:stackdriver][:plugins][:elasticsearch][:url] = "http://localhost:9200/_cluster/nodes/_local/stats?all=true"

default[:stackdriver][:plugins][:nginx][:enable] = false
default[:stackdriver][:plugins][:nginx][:url] = "http://localhost/nginx_status"
default[:stackdriver][:plugins][:nginx][:username] = false
default[:stackdriver][:plugins][:nginx][:password] = false

default[:stackdriver][:plugins][:redis][:enable] = false
default[:stackdriver][:plugins][:redis][:node] = "mynode"
default[:stackdriver][:plugins][:redis][:host] = "localhost"
default[:stackdriver][:plugins][:redis][:port] = "6379"
default[:stackdriver][:plugins][:redis][:timeout] = 2000

default[:stackdriver][:plugins][:mongodb][:enable] = false
default[:stackdriver][:plugins][:mongodb][:host] = "localhost"
default[:stackdriver][:plugins][:mongodb][:port] = "27017"
default[:stackdriver][:plugins][:mongodb][:username] = false
default[:stackdriver][:plugins][:mongodb][:password] = false
default[:stackdriver][:plugins][:mongodb][:secondary_query] = false