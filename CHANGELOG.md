# CHANGELOG for stackdriver

## 0.3.6:

* Remove dependency on response file for Debian installations.
  The file will be over-written by the template resource regardless; it served
  no function other than to install the package.

* Update GPG key location per Stackdriver documentation

* Syntax cleanup

## 0.3.4:

* Add default :upgrade action.

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
