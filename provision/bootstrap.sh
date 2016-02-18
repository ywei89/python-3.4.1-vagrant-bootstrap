#!/bin/bash

# This script is called directly from the Vagrantfile
su vagrant
## general config ##

#vagrant config?
export DEBIAN_FRONTEND=noninteractive
set -e # Exit script immediately on first error.
set -x # Print commands and their arguments as they are executed.

#update package manager resources
sudo apt-get update -y

## end general config ##

## main server installs ##

#basics
sudo apt-get install -y build-essential
sudo apt-get install -y libc6-dev libreadline-dev libz-dev libncursesw5-dev libssl-dev libgdbm-dev libsqlite3-dev libbz2-dev liblzma-dev tk-dev

sudo apt-get install -y git-core mercurial vim screen wget curl raptor-utils unzip ack-grep
sudo apt-get install -y tree vim-gnome

#apache, xvfb and firefox for selenium functional testing
sudo apt-get install -y apache2 xvfb firefox

sudo apt-get purge python-pip
sudo apt-get install -y python-pip
sudo pip install virtualenv virtualenvwrapper
sudo apt-get update -y

## end main server installs ##

## virtualenv work ##

sudo echo """
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
""" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

#Install Python 3.4 for to run in a virtual environment
cd /home/vagrant/
sudo wget https://www.python.org/ftp/python/3.4.1/Python-3.4.1.tar.xz
sudo tar -xvf Python-3.4.1.tar.xz
cd Python-3.4.1
sudo ./configure
make && sudo make install
sudo rm -rf Python-3.4.1*

#Create a virtualenv and ACTIVATE it
sudo pyvenv-3.4 /home/vagrant/.virtualenvs/py341

#finished with virtualenv work

echo "---"
echo "---"
echo "Box provisioned! SSH in to workon a project!"
echo "---"
echo "---"

exit
