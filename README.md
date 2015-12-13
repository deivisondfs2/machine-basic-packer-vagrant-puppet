# Basic Machine use vagrant with puppet

## Pre requirements:
####Instaled vagrant and virtualbox

### Run the following command:
```
 vagrant plugin install vagrant-puppet-install
```
```
 vagrant plugin install vagrant-librarian-puppet
```
```
 vagrant plugin install vagrant-hostsupdater
```

```
 vagrant up --provision
```


##inside the puppet instantiate these packages: 
https://github.com/deivisondfs2/machine-basic-packer-vagrant-puppet/blob/master/puppet/manifests/site.pp
```
include apache, php, nodejs, utils
```

##finished
