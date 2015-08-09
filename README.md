# [Stackdriver](http://www.stackdriver.com/) Chef cookbook

![Build Status](http://img.shields.io/travis/tablexi/chef-stackdriver.svg)

Handles the setup and installation of the stackdriver agent and plugins.

# Requirements

Supports CentOS, RHEL, Amazon, and Ubuntu linux distributions.

# Usage

Add stackdriver::default to your run list.

To use the plugins, change the enable attribute to true and add the stackdriver::plugins recipe to your run list.

# Attributes

## default

* action - Install (:install) or install and ensure stackdriver_agent is the latest version (:upgrade).  Default :upgrade.
* repo_url - location of the package repository.
* api_key - set the api key from your stackdriver account.
* config_collectd - should stackdriver handle collectd.conf autogeneration.  Default is true.
* enable - If set to false, the stackdriver agent will be disabled.  Default is true.
* gen_hostid - generate a host id. [Link](http://support.stackdriver.com/customer/portal/articles/1491718-server-monitoring-beta-)
* tags - set tags for your instance. [Link](http://support.stackdriver.com/customer/portal/articles/1491718-server-monitoring-beta-)

## plugins

`node['stackdriver']['plugins']`

### apache

* enable - enable the apache plugin.  Default is false.
* mod_status_url - Mod status URL for apache. Default = http://127.0.0.1/server-status?auto
* user - Mod status username for apache plugin.
* password - Mod status password for apache plugin.

### elasticsearch

* enable - enable the elasticsearch plugin. Default is false.
* http - elasticsearch protocol to use
* url - elasticsearch node url
* request_stats - the stats request path
* request_health - the health request path
* package - which yajl package to install

**NOTE**: This will get statistics for the entire cluster.

### memcached

* enable - enable the memcached plugin.  Default is false.
* host - location of the memcached instance.
* port - port for the memcached instance.

### mongodb

* enable - enable the mongodb plugin. Default is false.
* host - location of the mongodb instance.
* port - port of the mongodb isntance.
* username - if a username is required for access.
* password - if a password is required for access.
* secondary_query - all dbStat queries will be executed on a secondary node to avoid performance hits to the main db while adding a bit of latency to the metric data due to the eventual consistent nature of secondary nodes.  Default is false.

### nginx

* enable - enable the nginx plugin. Default is false.
* url - location of the nginx_status output.
* username - if a username is required for access.
password - if a password is required for access.

### redis

* enable - enable the redis plugin.  Default is false.
* package - install redis package dependency
* node - name of the redis node
* host - location of the redis instance.
* port - port for the redis instance.
* timeout - time to wait for missing values.

**NOTE**: The redis plugin requires manually running the yum-epel::default recipe on RHEL or other platforms within the family.

# Recipes

stackdriver::default - sets up the repository and installs the stackdriver agent.
stackdriver::plugins - handles plugin configuration for compatible collectd plugins.

# Development

1. Fork the repository from GitHub.
2. Clone your fork to your local machine:

        $ git clone git@github.com:USER/chefspec.git

3. Create a git branch

        $ git checkout -b my_bug_fix

4. Run guard:

        $ bundle exec guard

5. **Write tests**
6. Make your changes/patches/fixes, committing appropriately
7. Add a valid stackdriver api key to the `.kitchen.local.yml` file.

        provisioner:
          attributes:
            stackdriver:
              api_key: ''

8. Run kitchen test:

        $ bundle exec kitchen test

9. Push your changes to GitHub
10. Open a Pull Request

# Author

Author:: TABLE XI (<sysadmins@tablexi.com>)

# Contributors

* Kevin Reedy (<kevin@bellycard.com>)
* Christian Vozar (<christian@bellycard.com>)
* Enrico Stahn (<mail@enricostahn.com>)
* akshah123
