FROM ubuntu:22.04

COPY ./ /gpdb_src/

WORKDIR /
ENV DEBIAN_FRONTEND=noninteractive PATH=$PATH:/usr/local/gptools/bin TZ=Asia/Shanghai LANG=en_US.UTF-8

RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf \
&& ldconfig \
# install deb and configure
&& chmod +x gpdb_src/greenplum-oss/sysconf.bash \
&& gpdb_src/greenplum-oss/sysconf.bash \
compile openssh-7.9p1
&& cd gpdb_src/openssh-7.9p1 \
&& autoconf \
&& autoheader \
&& ./configure --sysconfdir=/etc/ssh \
&& make \
&& make install \
&& echo "sshd:x:1200:1200:/var/run/sshd:/usr/sbin/nologin" >> /etc/passwd \
&& ln -s /usr/local/sbin/sshd /usr/sbin/sshd \
# compile libxml2-2.9.0
&& cd /gpdb_src/libxml2-2.9.0 \
&& ./autogen.sh \
&& make \
&& make install \
&& cd / \
&& chmod +x gpdb_src/concourse/scripts/setup_gpadmin_user.bash \
&& gpdb_src/concourse/scripts/setup_gpadmin_user.bash \
# compile gp-xerces-3.1.2-p1
&& cd /gpdb_src/gp-xerces-3.1.2-p1 \
&& mkdir build \
&& cd build \
&& ../configure --prefix=/usr/local \
&& make -j8 \
&& make -j8 install \
&& cd /gpdb_src \
# Configure build environment to install at /usr/local/gpdb
&& ./configure --with-perl --with-python --with-libxml --with-gssapi --prefix=/usr/local/greenplum-db \
&& make -j8 \
&& make -j8 install \
# create init file for module pygresql
&& touch /usr/local/greenplum-db/lib/python/pygresql/__init__.py \
&& sed -ri 's/(GSSAPIAuthentication) yes/#\1 yes/' /etc/ssh/ssh_config \
# install gpbackup and gprestore
&& cp -r /gpdb_src/gptools /usr/local/ \
&& chmod 0755 /usr/local/gptools/bin/*
