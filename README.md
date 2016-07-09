# puppet-Packer
Puppet Module for installing [Packer](https://packer.io/).

## Requirements
- Puppet >= v4.x

## Usage
```puppet
include packer
```

```puppet
class { 'packer':
  version => '0.10.1',
}
```
