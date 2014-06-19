#!/bin/bash
# Set up the Puppet Master

# r10k -v info puppetfile install

### The following lines get a development version of tempest that fixes glance and neutron ids
#cd modules/tempest
#git fetch https://review.openstack.org/stackforge/puppet-tempest refs/changes/51/86751/1 && git checkout FETCH_HEAD
#cd ../..

vagrant ssh seed1  -c "
sudo puppet module install puppetlabs/apt 
"

vagrant ssh seed2  -c "
sudo puppet module install puppetlabs/apt 
"

