#!/bin/bash
#apt-get -y update
#apt-get -y install checkinstall build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev git
#cd /usr/local/src
#wget ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p195.tar.gz
#tar -xvzf ruby-2.0.0-p195.tar.gz
#cd /usr/local/src/ruby-2.0.0-p195/
#./configure
# make
#sudo checkinstall --pkgname ruby_2.0 --pkgversion 1.0 --default
sudo gem update --system 1.8.5
gem install bundler chef ruby-shadow --no-ri --no-rdoc
