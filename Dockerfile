##############################################################
# Dockerfile Version:   1.0
# Software:             BASHTOP
# Software Version:     0.8.18
# Software Website:     https://github.com/aristocratos/bashtop
# Licence:              Apache License 2.0
# Description:          BASHTOP
# Usage:                docker run -ti [-v [DATA FOLDER]:/data] bashtop:version
##############################################################


FROM centos:7
MAINTAINER Antony Le Bechec <antony.lebechec@gmail.com>
LABEL Software="bashtop" \
	Version="0.8.18" \
	Website="none" \
	Description="BASHTOP" \
	License="GNU Affero General Public License (AGPL)" \
	Usage="docker run [-v [DATA FOLDER]:/STARK/data] bashtop:version"



RUN mkdir /tmp/pwd && cd /tmp/pwd && \
	yum install -y git wget gcc make && \
	yum groupinstall -y "Development Tools" "Legacy Software Development" && \
	wget https://ftp.gnu.org/gnu/bash/bash-4.4.tar.gz && \
	tar xf bash-4.4.tar.gz && cd bash-4.4 && \
	./configure && make && make install && \
	mkdir -p /app && cd /app && \
	git clone https://github.com/aristocratos/bashtop.git . && \
	yum groupremove -y "Development Tools" "Legacy Software Development" && \
	yum erase -y git wget gcc make && \
	yum clean all && \
	rm -rf /var/cache/yum && \
	rm -rf /tmp/*

WORKDIR "/app"

ENTRYPOINT [ "/app/bashtop" ]
