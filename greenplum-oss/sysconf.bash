#!/bin/bash

cat > /etc/apt/sources.list << EOF
deb http://mirrors.163.com/ubuntu/ jammy main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ jammy-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ jammy-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ jammy-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ jammy-backports main restricted universe multiverse
EOF
apt update

apt-get update
apt-get install -y \
liblocale-gettext-perl \
libxau6 \
libbsd0 \
libxdmcp6 \
libxcb1 \
libx11-data \
libx11 \
libsigsegv2 \
m4 \
flex \
liblzo2 \
perl-modules-5.34 \
libgdbm6 \
libgdbm-compat4 \
libperl5.34 \
perl-base \
perl_5.34 \
libpython2.7-minimal \
python2.7-minimal \
libssl3 \
mime-support \
libexpat1 \
readline-common \
libreadline8 \
libsqlite3-0 \
libpython2.7-stdlib \
python2.7 \
libpython2-stdlib \
openssl \
ca-certificates \
libapparmor1 \
libdbus-1-3 \
dbus \
libmagic-mgc \
libmagic1 \
file \
libglib2.0-0 \
libgirepository-1.0-1 \
gir1.2-glib-2.0 \
less \
libglib2.0-data \
libicu70 \
libjson-c5 \
libxml2 \
libyaml-0-2 \
locales-all \
netbase \
shared-mime-info \
xdg-user-dirs \
xz-utils \
libisc1105 \
libgeoip1 \
libkrb5support0 \
libk5crypto3 \
libkeyutils1 \
libkrb5-3 \
libgssapi-krb5-2 \
libdns1110 \
libisccc161 \
libisccfg163 \
libbind9-161 \
liblwres161 \
bind9-host \
geoip-database \
krb5-locales \
libedit2 \
libpsl5 \
libxmuu1 \
manpages \
openssh-client \
publicsuffix \
wget \
xauth \
autoconf \
autotools-dev \
automake \
binutils-common \
libbinutils \
binutils-x86-64-linux-gnu \
binutils \
libbison-dev \
bison \
libc-dev-bin \
linux-libc-dev \
libc6-dev \
gcc-12-base \
libisl23 \
libmpfr6 \
libmpc3 \
cpp-12 \
cpp \
libcc1-0 \
libgomp1 \
libitm1 \
libatomic1 \
libasan8 \
liblsan0 \
libtsan0 \
libubsan1 \
libquadmath0 \
libgcc-12-dev \
libgcc-s1 \
gcc-12 \
gcc \
libstdc++-12-dev \
g++-12 \
g++ \
make \
libdpkg-perl \
patch \
dpkg-dev \
build-essential \
bzip2-doc \
ccache \
libcgroup1 \
cgroup-tools \
cmake-data \
libarchive13 \
libroken18-heimdal \
libasn1-8-heimdal \
libheimbase1-heimdal \
libhcrypto4-heimdal \
libwind0-heimdal \
libhx509-5-heimdal \
libkrb5-26-heimdal \
libheimntlm0-heimdal \
libgssapi3-heimdal \
libsasl2-modules-db \
libsasl2-2 \
libldap-common \
libldap-2.5-0 \
libnghttp2-14 \
librtmp1 \
libcurl4 \
libjsoncpp25 \
librhash0 \
libuv1 \
cmake \
curl \
libassuan0 \
gpgconf \
libksba8 \
libnpth0 \
dirmngr \
libfakeroot \
fakeroot \
equivs \
libcurl3-gnutls \
liberror-perl \
git-man \
git \
gnupg-l10n \
gnupg-utils \
gpg \
pinentry-curses \
gpg-agent \
gpg-wks-client \
gpg-wks-server \
gpgsm \
gnupg \
inetutils-ping \
libgssrpc4 \
libkdb5-10 \
libkadm5srv-mit12 \
libevent-2.1-7 \
libverto-libevent1 \
krb5-config \
libkadm5clnt-mit12 \
krb5-user \
krb5-kdc \
krb5-admin-server \
comerr-dev \
krb5-multidev \
libalgorithm-diff-perl \
libalgorithm-diff-xs-perl \
libalgorithm-merge-perl \
libapr1 \
uuid-dev \
libsctp1 \
libsctp-dev \
libapr1-dev \
libbz2-dev \
libcurl4-gnutls-dev \
libevent-core-2.1-7 \
libevent-extra-2.1-7 \
libevent-pthreads-2.1-7 \
libevent-openssl-2.1-7 \
libevent-dev \
libexpat1-dev \
libfile-fcntllock-perl \
libfl2 \
libfl-dev \
libltdl7 \
libltdl-dev \
libpam0g-dev \
libperl-dev \
libpq5 \
libpython2.7 \
libpython2.7-dev \
libpython-all-dev \
libtinfo-dev \
libreadline-dev \
libsasl2-modules \
libssl-dev \
libtool \
libzstd-dev \
manpages-dev \
net-tools \
ninja-build \
python-all \
python2.7-dev \ 
python-all-dev \
python-six \
python-decorator \
python2-pip-whl \
python-pip \
python-pkg-resources \
python-setuptools \
zlib1g-dev \
libkrb5-dev \
libyaml-dev \
locales-all 

sub_path="/gpdb_src/greenplum-oss"
#through pip install
#build whl
for tarball in `cat ${sub_path}/whl_build_order.txt`;do
  tarball=${tarball#*_}	
  tar -zxf ${sub_path}/by_pip_install/${tarball} -C ${sub_path}/by_pip_install
  path_name=${tarball%.tar.gz*}
  cd ${sub_path}/by_pip_install/${path_name}
  python setup.py bdist_wheel
  cp ./dist/* ${sub_path}/by_pip_install
  cd -
done

#install whl
for whl in `cat ${sub_path}/whl_install_order.txt`;do
  whl=${whl#*_}
  pip install ${sub_path}/by_pip_install/${whl}
done


tee -a /etc/sysctl.conf << EOF
kernel.shmmax = 5000000000000
kernel.shmmni = 32768
kernel.shmall = 40000000000
kernel.sem = 1000 32768000 1000 32768
kernel.msgmnb = 1048576
kernel.msgmax = 1048576
kernel.msgmni = 32768

net.core.netdev_max_backlog = 80000
net.core.rmem_default = 2097152
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216

vm.overcommit_memory = 2
vm.overcommit_ratio = 95
EOF

sysctl -p

mkdir -p /etc/security/limits.d
tee -a /etc/security/limits.d/90-greenplum.conf << EOF
* soft nofile 1048576
* hard nofile 1048576
* soft nproc 1048576
* hard nproc 1048576
EOF

ulimit -n 65536
