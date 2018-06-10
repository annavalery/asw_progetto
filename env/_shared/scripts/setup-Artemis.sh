#!/bin/bash

source "/home/asw/_shared/scripts/common.sh"

# set up Java constants 
ARTEMIS_VERSION=2.6.0


# http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz

#https://www.apache.org/dyn/closer.cgi?filename=activemq/activemq-artemis/2.6.0/apache-artemis-2.6.0-bin.tar.gz&action=download


ARTEMIS_FILE_NAME=apache-artemis-${ARTEMIS_VERSION}-bin
#JAVA_FILE_NAME=jdk-${JAVA_VERSION}u${JAVA_MINOR_VERSION}-linux-x64

ARTEMIS_ARCHIVE=${ARTEMIS_FILE_NAME}.tar.gz
#JAVA_ARCHIVE=${JAVA_FILE_NAME}.tar.gz

GET_ARTEMIS_URL=http://apache.mirrors.spacedump.net/activemq/activemq-artemis/2.6.0/apache-artemis-2.6.0-bin.tar.gz
#GET_JAVA_URL=http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_MINOR_VERSION}-b${JAVA_BUILD}/${JAVA_HEX}


ARTEMIS_PATH=/usr/local/${ARTEMIS_ARCHIVE}
#JAVA_JDK_PATH=/usr/local/jdk1.${JAVA_VERSION}.0_${JAVA_MINOR_VERSION} 

# e.g., /usr/local/jdk1.8.0_161

function installLocalArtemis {
	echo "======================================"
	echo "Installing Artemis  ${ARTEMIS_ARCHIVE}"
	echo "======================================"
	FILE=${ASW_DOWNLOADS}/$ARTEMIS_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteArtemis {
	echo "======================================"
	echo "Downloading Artemis ${ARTEMIS_VERSION}"
	echo "======================================"
	#wget -nv -P ${ASW_DOWNLOADS} "${GET_ARTEMIS_URL}" 
	wget -q -P ${ASW_DOWNLOADS} "${GET_ARTEMIS_URL}" 
	#wget -nv -P ${ASW_DOWNLOADS} --header "Cookie: oraclelicense=accept-securebackup-cookie;" "${GET_JAVA_URL}/${JAVA_ARCHIVE}" 
	installLocalArtemis
}

function setupEnvVars {

	echo "======================================"
	echo "Creating Artemis environment variables"
	echo "======================================"
	echo export ARTEMIS_HOME=/usr/local/apache-artemis-2.6.0 >> /etc/profile.d/artemis.sh
	echo export PATH=\${PATH}:\${ARTEMIS_HOME}/bin >> /etc/profile.d/artemis.sh
}

function installArtemis {
	echo "verify if just downloaded"
	if downloadExists $ARTEMIS_ARCHIVE; then
		installLocalArtemis
	else
		installRemoteArtemis
	fi
}

echo "======================================"
echo "Setup Artemis"
echo "======================================"

installArtemis
setupEnvVars