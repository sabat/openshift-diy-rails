openshift-diy-rails
===================

Ruby 2.2.2, Rails 4.2.1 on OpenShift platform


Installation
-------------------

1.  [Create Do-It-Yourself application](https://openshift.redhat.com/app/console/application_types)
2.  Log into a remote machine (check [instruction](https://openshift.redhat.com/community/developers/remote-access))
3.  Execute  
`cd $OPENSHIFT_TMP_DIR`  
`wget https://raw.github.com/sabat/openshift-diy-rails/master/install.sh`  
`chmod u+x install.sh`  
`./install.sh`
4.  Wait until installation is finished. It should take in about 15-20 minutes.
5.  Clone locally repository: `git clone https://github.com/sabat/openshift-diy-rails.git`
6.  Feel free to modify code, set up remote repository & push your code to OpenShift platform.
7.  Have fun :-)
