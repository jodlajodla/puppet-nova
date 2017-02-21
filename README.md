puppet-nova
===

This repository contains fix when installing Packstack with Ironicf for OpenStack Newton release (otherwise it shouldn't be used). There are only few changes in `manifests/scheduler/filter.pp` file - removal of anything that depends on `$scheduler_host_manager` since it is duplicated in official repository and Packstack installation fails.

Development and general information
-----------------------------------

For any additional information about development or anything other connected to puppet-nova, please refer to original README (in file `README_ORIGINAL`), or check official repository located at https://github.com/openstack/puppet-nova

License
-------

The software is provided "as is", without warranty of any kind from my side. All files in project are included as fetched from source and may have been changed in the way to make things work with technologies specified above. Please read original license which is added to the project if you want to further use this software or modify it. All respective rights reserved to authors and contributors.
