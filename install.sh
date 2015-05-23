#!/bin/bash

RUBY_VER=2.2.2
RAILS_VER=4.2.1


export OPENSHIFT_RUNTIME_DIR=$OPENSHIFT_HOMEDIR/app-root/runtime

cd $OPENSHIFT_TMP_DIR

# get & compile yaml
rm -vf yaml-0.1.4.tar.gz
wget http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz
tar xzf yaml-0.1.4.tar.gz
cd yaml-0.1.4
./configure --prefix=$OPENSHIFT_RUNTIME_DIR
make
make install

# clean up yaml sources
cd $OPENSHIFT_TMP_DIR
rm -rf yaml*

# get ruby
rm -vf ruby-$RUBY_VER.tar.gz
wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-$RUBY_VER.tar.gz
tar xzf ruby-$RUBY_VER.tar.gz
cd ruby-$RUBY_VER

# export directory with yaml.h
export C_INCLUDE_PATH=$OPENSHIFT_RUNTIME_DIR/include

# export directory with libyaml
export LIBYAMLPATH=$OPENSHIFT_RUNTIME_DIR/lib

cd ext/psych
sed -i '1i $LIBPATH << ENV["LIBYAMLPATH"]' extconf.rb

cd $OPENSHIFT_TMP_DIR
cd ruby-$RUBY_VER

# compile ruby
./configure --disable-install-doc --prefix=$OPENSHIFT_RUNTIME_DIR
make
make install

# Fix problem where gem tries to bind to 0.0.0.0 to do DNS lookups (ugh)
sed --in-place -r -e 's|.0.0.0.0.|ENV["OPENSHIFT_DIY_IP"]|' lib/ruby/2.2.0/resolv.rb

export PATH=$OPENSHIFT_RUNTIME_DIR/bin:$PATH

# clean up ruby sources
cd $OPENSHIFT_TMP_DIR
rm -rf ruby*

# install rails
gem install rails --version $RAILS_VER --no-rdoc --no-ri -V

