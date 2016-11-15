# suricata

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

Install and manages the Open Source IDS / IPS / NSM engine Suricata. It works on CentOS 7 with Puppet 4.8.

## Module Description

Suricata is a widely used IDS/NSM engine. This puppet module takes care of the whole lifecycle including installing, configuration and service managment. The goal of the module is to not limit any configuration options that Suricata provides.  

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What suricata affects

* Configuration files and directories (created and written to)
* Packages/service/configuration files for Suricata.
* Creating of log files

### Beginning with suricata

To have suricata installed with basic setup,  declare the suricata class.

```puppet
  include '::suricata'
``` 

The Puppet modules applies a default configuration based on your operating system. By default it will use your first interface as montior interafce for Suricata and applies a minimal suricata.yaml configuration. 

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

Currently limitied to RHEL version 7.
Tested with Puppet version 4.8

## Development

1. Fork the repo.

2. Run the tests. We only take pull requests with passing tests, and it's great to know that you have a clean slate

3. Add a test for your change. Only refactoring and documentation changes require no new tests. If you are adding functionality or fixing a bug, please add a test.

4. Make the test pass.

5. Push to your fork and submit a pull request.
