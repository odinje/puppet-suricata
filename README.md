Puppet-Suricata
========

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with suricata](#setup)
    * [What suricata affects](#what-suricata-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with suricata](#beginning-with-suricata)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The Puppet-Suricata module installs and manages the Open Source IDS / IPS / NSM engine [Suricata](https://suricata-ids.org/).

## Module Description

Suricata is a widely used IDS/NSM engine. This puppet module takes care of the whole lifecycle including installing, configuration and service managment. The goal of this puppet module is to not limit any configuration options that Suricata provides.

## Setup

### What suricata affects

* Configuration files and directories (created and written to)
* Packages/service/configuration files for Suricata.
* Log files from Suricata

### Beginning with suricata

To have the Puppet-Suricata module installed with a basic setup, declare the suricata class.

```puppet
  include '::suricata'
``` 

The Puppet modules applies a default configuration based on your operating system. By default it will use your first interface as montior interafce for Suricata and applies a minimal suricata.yaml configuration. 
For more configuration option please see the suricata.yaml on the [Suricata Github clone repository](https://github.com/OISF/suricata/blob/master/suricata.yaml.in) and the [Suricata Documentation](https://suricata.readthedocs.io/en/latest/configuration/suricata-yaml.html).

## Usage

This module includes a "Suricata" class with default options normal to a standard suricata setup. Below are some examples to change the default configuration.

#### Just want minimal Suricata config?

```puppet
  include '::suricata'
```
#### Using RHEL and dont want this module to install the epel repository?

```puppet
  class { ::suricata:
    configure_epel => false,
  }
```

#### Don't want this module to manage suricatas user, and run suricata as another user?

```puppet
  class { ::suricata:
    manage_user => false,
    user        => user,
    group       => user,
  }
```

#### Add more interfaces to listen on? Or dont listen on any? 

By default this module uses the first interfaces found in the fact 'interfaces', you can change this to listen on specified interfaces like eth0, eth1, eth2.

```puppet
  class { ::suricata: 
    interfaces => "eth0, eth1, eth2",
  }
```

Setting interfaces to false will not add any interfaces to the commandline options to suricata. 

```puppet
  class { ::suricata:
    interfaces => false,
  }
```

#### Want to add more commandline options to Suricata?

```puppet
  class {::suricata:
    cmd_options => '--af-packet=eth0',  
  }
```

#### Merge your suricata configuration with the basic one this module provides?

The hash below will change the configuration of the rules-files to the value below.

```puppet
  class {::suricata:
    main_config => { 'rules-files' =>  [
                      'emerging-attack_response.rules',
                      'emerging-chat.rules',
                      'emerging-current_events.rules',
                      'emerging-dns.rules'
                     ]
                   }
  }
```

This configuration can also be done in hiera.

```puppet
  class {::suricata: }
```

```yaml
suricata::main_config:
  rule-files:
   - emerging-attack_response.rules
   - emerging-chat.rules
   - emerging-current_events.rules
   - emerging-dns.rules
```

#### Don't use the basic configuration and write the configuration from scratch

If you don't want to merge your configuration with the modules this can be turned off. Then only the configuration you add as a hash or hiera will be used. 

```puppet
  class {::suricata:
    basic_configuration_enabled = false,
  }
```

#### Add a lua script to Suricatas script folder

This module includes a resource for adding scripts. This resource adds the script to lua-output directory inside suricatas configuration directory and sets the correct permissions.

```puppet
  suricata::script { 'stats.lua':
    ensure => 'present',
    source => 'puppet:///modules/module/stats.lua',
  }
```

## Reference

**Classes**

**Public Classes**

  * suricata: Main class, includes all other classes.

**Private Classes**

  * suricata::install:
  * suricata::config: 
  * suricata::service:

**Public Defined Classes**

  * suricata::script

**Parameters within suricata class**

#### `ensure`

Choose whether suricata should be present, absent, latest or version
Defaults to 'present'

#### `package_manage`

Choose whether this module should handle installation of Suricata

Defaults to true

#### `package_name`

Name of suricata package in repo

Defaults to 'suricata'

#### `config_dir`

Directory of configuration files

Defaults to '/etc/suricata'

#### `config_name`

Name of suricata main configuration

Defaults to 'suricata.yaml'

#### `log_dir`
Directory of suricatas log files

Defaults to '/var/log/suricata'

### `service_manage`

Choose whether this module should manage Suricata service

Defaults to true

#### `service_ensure`

Choose whether suricata service is running or stopped

Defaults to 'running'

#### `service_enable`

Choose to enable suricata at startup or not

Defaults to true

#### `service_provider`

Which service provider suricatas service will use

Default depends on os

#### `manage_user`

Choose wheter this module will manage the user

Defaults to true

#### `user`

Name of user that suricata is running as and owner of configuration files

Defaults to 'suricata'

#### `group`

Name of users group

Defaults to 'suricata'

#### `user_shell`

Path to user shell

Default depends on os

#### `bin_path`

Path to suricatas binary file

Default depends on os

#### `basic_configuration_enabled`

Choose whether to apply the modules included basic configuration

Defaults to true

#### `configure_epel`

Choose whether this module will install epel from offical repository

Default to true if os is RHEL 

#### `interfaces`

A string of comma-separated interfaces

Defaults to the first interfaces found in the interface fact

#### `cmd_options`

A string of additonal commandline options

Defaults to undef

#### `main_config`

A hash of suricatas main configuration options

#### `classification_config`

An array of suricatas classification configuration options

#### `reference_config`

An array of suricatas reference configuration options

#### `threshold_config`

An array of suricatas threshold configuration options

**Parameters within suricata::script defined type**

#### `source`

Puppet URI to where the script is stored

#### `ensure`

Choose whether the script should be present or absent

Defaults to present

#### `script_name`

Name of the script

Default to the name of the instance

## Limitations

This module is currently limitied to RHEL/CentOS version 7, Debian 8 and Ubuntu 16.04 with Puppet version 4.8 or greater.
Currently tested on CentOS 7 with Puppet 4.8

## Development

We are happy to recieve commits as long as they follow the rules and guidelines below. If you want to fork the module somewhere else this is also fine as long as you mention or link the original module along with the documentation and code.

Rules:

* All code must follow the [Puppet Style Guide](https://docs.puppet.com/guides/style_guide.html).
* Added code must pass the included tests. If you add new fuctions, please create puppet tests for these.
* Make sure not to break any existing code or functions of this module.
* New functions must be documented in the Github repository.
* All commits must follow the [Github Commit Guide](https://github.com/erlang/otp/wiki/writing-good-commit-messages).


Guide:

1. Fork the repo.
2. Run the tests to verify that the module works as intended.
3. Add new code, bugfixes and documentation if needed.
4. Make sure that all the tests pass.
5. Push to your fork and submit a pull request.
6. Create an issue on Github if you have any problems.
