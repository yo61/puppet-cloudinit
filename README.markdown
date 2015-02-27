#### Table of Contents

1. [Overview - What is the cloudinit module](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with cloudinit](#setup)
    * [What cloudinit affects](#what-cloudinit-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cloudinit](#beginning-with-cloudinit)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs cloudinit scripts on Amazon EC2 instances

## Module Description

Cloud-init is the defacto multi-distribution package that handles early initialization of a cloud instance.

This module helps you install cloud-init scripts to your EC2 nodes.

## Setup

### What cloudinit affects

cloudinit::script installs scripts to the cloudinit script base directory, /var/lib/cloud/scripts

### Beginning with cloudinit

To install a per-instance cloudinit script:

```puppet
  cloudinit::script{'my-first-cloudinit-script':
    source      => "puppet:///modules/${module_name}/my-first-cloudinit-script",
  }
```

This is the same thing, but explicitly specifying the default values:

```puppet
  cloudinit::script{'my-first-cloudinit-script':
    ensure      => present,
    source      => "puppet:///modules/${module_name}/my-first-cloudinit-script",
    script_type => 'per-instance',
  }
```

## Usage

### Classes and Defined Types

#### Defined Type: `cloudinit::script`

Installs a cloud-init script in the correct location according to its type.

```puppet
  cloudinit::script{'my-first-cloudinit-script':
    source      => "puppet:///modules/${module_name}/my-first-cloudinit-script",
  }
```
**Parameters within `cloudinit::script`:**
#####`ensure`
Specify whether the script file is present or absent. Default: 'present'. Valid values are 'present' and 'absent'.
#####`source`
The source of the script file. See [puppet documentation](https://docs.puppetlabs.com/references/latest/type.html#file-attribute-source) for usage. Exactly one of source or content must be specified.
#####`content`
The desired contents of the script file. See [puppet documentation](https://docs.puppetlabs.com/references/latest/type.html#file-attribute-content) for details. Exactly one of source or content must be specified.
#####`script_type`
The type of script to install. This determines the location of the script within the script base dir. Default: 'per-instance'. Valid values are 'per-instance', 'per-boot', and 'per-once'.
#####`script_base`
The cloud-init script base directory. Default: '/var/lib/cloud/scripts'.
#####`owner`
The user to whom the file should belong. See [puppet documentation](https://docs.puppetlabs.com/references/latest/type.html#file-attribute-owner). Default: 'root'
#####`group`
Which group should own the file. See [puppet documentation](https://docs.puppetlabs.com/references/latest/type.html#file-attribute-group). Default: '0'.
#####`mode`
The desired permissions mode for the script. See [puppet documentation](https://docs.puppetlabs.com/references/latest/type.html#file-attribute-mode). Default: '0750'.

## Reference

### Classes

This module contains no classes.

### Defined Types

* `cloundinit::script`: installs a cloudinit script

## Limitations

This module *should* work on any EC2 platform, but it has only been tested on Ubuntu 12.10 and CentOS 7.

## Development

See separate [CONTRIBUTING.md](CONTRIBUTING.md) document.
