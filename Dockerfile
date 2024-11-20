# https://index.docker.io/_/centos/
FROM centos:7

# https://github.com/vpalacio
MAINTAINER Victor Palacio <vpalacio@gmail.com>

ENV PACKAGE InterMapper-5.8.2-1.x86_64.5x.rpm

# Install InterMapper and its dependencies.
RUN yum -y update && \
    yum -y groupinstall "Compatibility Libraries" && \
    yum -y install \
      java-1.8.0 \
      psmisc \
      which \
      && \
    curl -o /tmp/${PACKAGE} -L "https://anfadmin.ucsd.edu/linux/RHEL/7/x86_64/" && \
    yum -y --nogpgcheck localinstall /tmp/${PACKAGE} && \
    rm -f /tmp/${PACKAGE} && \
    yum clean all

COPY ssl.conf /var/local/InterMapper_Settings/ssl.conf

COPY start.sh /start.sh
CMD /start.sh
