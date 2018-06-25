# based on Debian 9
FROM debian:stretch

# populate sources.list
ADD sources.list /etc/apt/sources.list

# update
RUN \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get clean && \
	:

# install build dependencies
RUN dpkg --add-architecture i386
RUN \
	apt-get update && \
	apt-get -y build-dep gcc binutils llvm-defaults && \
	apt-get clean && \
	:
RUN \
	apt-get update && \
	apt-get -y install gcc-arm-none-eabi cmake python-dev swig ant bc proguard maven-debian-helper libemma-java libasm4-java libguava-java libnb-platform18-java libnb-org-openide-util-java libandroidsdk-ddmlib-java libmaven-source-plugin-java libfreemarker-java libmaven-javadoc-plugin-java ca-cacert curl gawk libgmp3-dev libmpfr-dev libmpc-dev git-core gperf libncurses-dev squashfs-tools pngcrush zip zlib1g-dev lzma libc6-dev-i386 g++-multilib lib32z1-dev lib32readline-dev lib32ncurses5-dev zlib1g-dev:i386 xsltproc python-mako schedtool gradle dirmngr libandroidsdk-sdklib-java eclipse-jdt libgradle-android-plugin-java android-sdk-build-tools android-sdk-platform-23 aapt lzop && \
	apt-get clean && \
	:
RUN \
	apt-get update && \
	apt-get -y install libssl-dev kmod repo && \
	apt-get clean && \
	:

# use /src as working directory
WORKDIR /src

# run a startup script
ADD entry.sh /entry.sh
ENTRYPOINT ["/bin/bash", "/entry.sh"]
