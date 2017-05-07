#!/bin/bash

apt-get -y install libssl-dev libfreetype6-dev tcl-dev tk-dev libsqlite3-dev 


wget -c https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz 
tar xzf Python-3.6.1.tgz 
cd Python-3.6.1 
./configure --prefix=/opt/Python-3.6.1 --with-ensurepip=install 
mkdir /opt/Python-3.6.1 
make
make install
cd -
wget -c https://pypi.python.org/packages/d4/0c/9840c08189e030873387a73b90ada981885010dd9aea134d6de30cd24cb8/virtualenv-15.1.0.tar.gz#md5=44e19f4134906fe2d75124427dc9b716
tar xvzf virtualenv-15.1.0.tar.gz
cd virtualenv-15.1.0
/opt/Python-3.6.1/bin/python3 ./virtualenv.py -p /opt/Python-3.6.1/bin/python3 /opt/NUMPY1
cd -
#virtualenv -p /opt/Python-3.6.1/bin/python3 /opt/NUMPY && \ 
source /opt/NUMPY1/bin/activate
[ "/opt/NUMPY1/bin/pip" == "`which pip`" ] || exit 1
#exit 1
which pip
pip --no-cache-dir install ipython
pip --no-cache-dir install numpy
pip --no-cache-dir install matplotlib
pip --no-cache-dir install scipy
deactivate
[ -h /usr/local/bin/activate-numpy ] && rm /usr/local/bin/activate-numpy
ln -s /opt/NUMPY1/bin/activate /usr/local/bin/activate-numpy 
