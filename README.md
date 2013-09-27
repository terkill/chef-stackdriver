# stackdriver cookbook

Handles the setup and installation of the stackdriver agent.

# Requirements

Supports CentOS, RHEL, Amazon, and Ubuntu linux distributions.

# Usage

add stackdriver::default to your run list.

# Attributes

repo_url - location of the package repository.
api_key - set the api key from your stackdriver account.
config_collectd - should stackdriver handle collectd.conf autogeneration.  Default is true.
<code>node['apache']['mod_status_url']<code>  - Mod status URL for apache. Default = http://127.0.0.1/server-status?auto
<code>node['apache']['user']<code>  - Mod status username for apache plugin.
<code>node['apache']['password']<code>  - Mod status password for apache plugin.

# Recipes

stackdriver::default - sets up the repository and installs the stackdriver agent.
stackdriver::apache - sets up apache plugin with custom settings that are not picked up automatically by stackdriver agent.

# Author

Author:: TABLE XI (<sysadmins@tablexi.com>)

Author:: Kevin Reedy (<kevin@bellycard.com>)
