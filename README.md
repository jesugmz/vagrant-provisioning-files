Vagrant provisioning files
==========================

Vagrant provisioning files for different stacks.

# Prerequisites
Vagrant synced_folder need vagrant-vbguest plugin:
```
$: vagrant plugin install vagrant-vbguest
```

## CentOS 7 LAMP
Apache/MariaDB/PHP.
    * Apache 2.4.* MPM prefork from base repo.
    * MariaDB 10.1 from MariaDB repo.
    * PHP 5.6 with mod_php from remi repo.
