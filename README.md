# Kapture Ansible role

> Ansible role that provisions a target system with kapture setup

Configured to use:

* Plex - plays content
* Transmission - downloads torrents
* flexget - used to read from showrss and pull in new episodes
* Apple file share: Pointing to storage device
* Samba: Pointing to storage device


# Running via vagrant

This repo is set up to be able to spin up a new kapture node locally, without having to go through the using your own pi hardware and whatnot.

## OSX pre-req's

You'll need the following tools installed first:

```bash
# Install Brew if not already installed
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Cask within brew
brew tap caskroom/cask

# use Brew to install vagrant and virtualbox 
brew cask install vagrant virtualbox
``` 

## Starting up kapture in vagrant

To get started, simply run the following:

```bash
vagrant up
```

This will take some time to set up kapture the way it needs to be configured. In the meantime, grab a beer.

Once that's complete (you may see some warnings and errors but as long as it gets to a part where it says `System built successfully.  Connect to...` you're good to go).  Then simply connect to:

[http://kapture-vagrant.local](http://kapture-vagrant.local)

or if your mDNS isn't working:

[http://192.168.33.10/](http://192.168.33.11/)


# Pi setup

First use the following image flashed onto a sd card in order to get a base OS:

https://ubuntu-pi-flavour-maker.org/xenial/ubuntu-standard-16.04-server-armhf-raspberry-pi.img.xz.torrent

Put the sd card into the pi, power it up, and run the following in this directory in order to transform a pi into a kapture:


```bash
ansible-playbook -i inventory/xenial initial-setup.yml --ask-sudo-pass
```

**On first run** It will prompt you for a sudo pass, which is ```ubuntu```.  Let that complete and you should have a new kapture device located at:

http://kapture.local/

It will also set a SSH password for the ```ubuntu``` user of: ```kapture is the bombest thing ever```.  Last it sets up some authorized_keys for that user as defined by the group_vars file.


Hardware requirements
---------------------

* Raspberry PI (or other pi's) w/ ubuntu 16.04
* SSH key-based login configured properly with sudo access from machine running ansible (`ssh_authorized_keys`)
* Storage device setup, connected, and working correctly (you may need to change the target device via `storage_block_device`.  See `group_vars/pi.yml`)


Troubleshooting
---------------

If plex won't play certain videos because the bananapi isn't powerful enough, you'll need to use the included script ```convert-avi-to-x264.sh``` on the file that won't play properly.
