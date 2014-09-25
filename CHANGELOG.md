# CHANGELOG for stackdriver

## 0.4.2:

* add kitchen test gem
* add generate hostid
* add tags
* use yum-epel cookbook

## 0.4.1:

* update berkshelf to version 3
* update rubocop and fix syntax
* add memcache plugin

## 0.4.0:

* update redis package dependency.
* add end of line character to template files.

## 0.3.9:

* update elasticsearch package dependency

## 0.3.8:

* fix specs

## 0.3.6:

* Remove dependency on response file for Debian installations.
  The file will be over-written by the template resource regardless; it served
  no function other than to install the package.

* Update GPG key location per Stackdriver documentation

* Syntax cleanup

## 0.3.4:

* Add default :upgrade action.
* Lock yum cookbook version.

## 0.3.3:

* Added delete conf file resource.

## 0.3.2:

* Added recipe to setup custom apache plugin

## 0.3.1:

* fixed redhat platform name
* added enable attribute

## 0.3.0:

* Added collectd plugins (elasticcache, mongodb, nginx, redis)
* added travis support

## 0.2.0:

* Added support for Ubuntu 10.04, 12.04, and 12.10

## 0.1.0:

* Initial release.
