# Puppet-Suricata

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
For more configuration option please see the suricata.yaml on the [Suricata Github clone repository](https://github.com/inliniac/suricata/blob/master/suricata.yaml.in) and the [Suricata Documentation](http://jasonish-suricata.readthedocs.io/en/latest/configuration/suricata-yaml.html).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

**Classes**

**Public Classes**

  * suricata: Main class, includes all other classes.

**Private Classes**

  * suricata::install:
  * suricata::config: 
  * suricata::service:

Parameters
The following parameters are available in the ::suricata class:

####`ensure`

Ensure that suricata is installed. Default value: 'present'

####`config_dir`

Where suricatas configuraitons files will be stored. Default value: '/etc/suricata'

####`config_name`

Name of suricata configuration file. Default value: 'suricata.yaml'

####`service_ensure`
####`service_enable`
####`service_provider`
####`exec_path` 
####`interfaces`
####`base_config_enabled`
####`config`


## Limitations

This module is currently limitied to RHEL version 7 with Puppet version 4.8 or greater.
Currently tested on CentOS 7 with Puppet 4.8

## Development

We are happy to recieve comits as long as they follow the rules and guidelines below. If you want to fork the module somewhere else this is also fine as long as you mention or link the original module along with the documentation and code.

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
