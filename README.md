# stackdriver cookbook

Handles the setup and installation of the stackdriver agent and plugins.

# Requirements

Supports CentOS, RHEL, Amazon, and Ubuntu linux distributions.

# Usage

Add stackdriver::default to your run list.

To use the plugins, change the enable attribute to true and add the stackdriver::plugins recipe to your run list.

# Attributes

## default

repo_url - location of the package repository.
api_key - set the api key from your stackdriver account.
config_collectd - should stackdriver handle collectd.conf autogeneration.  Default is true.

## plugins

`node[:stackdriver][:plugins]`

### elasticcache

enable - enable the elasticcache plugin. Default is false.
url - elastic search status url

### mongodb

enable - enable the mongodb plugin. Default is false.
host - location of the mongodb instance.
port - port of the mongodb isntance.
username - if a username is required for access.
password - if a password is required for access.
secondary_query - all dbStat queries will be executed on a secondary node to avoid performance hits to the main db while adding a bit of latency to the metric data due to the eventual consistent nature of secondary nodes.  Default is false.

### nginx

enable - enable the nginx plugin. Default is false.
url - location of the nginx_status output.
username - if a username is required for access.
password - if a password is required for access.

### redis

enable - enable the redis plugin.  Default is false.
node - name of the redis node
host - location of the redis instance.
port - port for the redis instance.
timeout - time to wait for missing values.

# Recipes

stackdriver::default - sets up the repository and installs the stackdriver agent.
stackdriver::plugins - handles plugin configuration for compatible collectd plugins.

# Author

Author:: TABLE XI (<sysadmins@tablexi.com>)

Author:: Kevin Reedy (<kevin@bellycard.com>)
