FROM centos:7
MAINTAINER "you" <saulnoz@gmail.com>

RUN yum update && yum install -y git
RUN yum install -y epel-release
RUN yum install -y ansible
RUN yum install -y openssl policycoreutils policycoreutils-python
COPY config.tar.gz /opt
COPY roles.tar.gz /opt
COPY ansible.cfg /opt
COPY playbook.yml /opt
RUN cd opt && tar xvfz /opt/config.tar.gz && tar xvfz /opt/roles.tar.gz
RUN cd /opt && ansible-playbook -i config -c local playbook.yml
RUN sed -i "s/run_as_user=''/run_as_user='nexus'/g" /usr/local/nexus/bin/nexus
CMD /usr/local/nexus/bin/nexus run
