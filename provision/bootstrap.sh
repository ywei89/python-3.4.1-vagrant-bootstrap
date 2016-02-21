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

sudo apt-get install -y git-core mercurial screen wget curl raptor-utils unzip ack-grep
sudo apt-get install -y tree

#apache, xvfb and firefox for selenium functional testing
sudo apt-get install -y xvfb firefox

sudo apt-get purge -y python-pip
sudo apt-get install -y python-pip
sudo apt-get update -y

## end main server installs ##

#Install Python 3.4 for to run in a virtual environment
cd /vagrant
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
pyenv install 3.4.1
pyenv rehash

#finished with virtualenv work

echo "---"
echo "Box provisioned! SSH in to workon a project!"
echo "---"

exit
