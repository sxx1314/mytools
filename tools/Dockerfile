FROM ubuntu:18.04


RUN apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get install -y \
 build-essential \ 
 asciidoc \
 binutils \
 bzip2 \
 gawk \
 gettext \
 git \
 libncurses5-dev \
 libz-dev \
 patch \
 python3.8 \
 python3-pip \
 python2.7 \
 unzip \
 zlib1g-dev \
 lib32gcc1 \
 libc6-dev-i386 \
 subversion \
 flex uglifyjs \
 git-core \
 gcc-multilib \ 
 p7zip \
 p7zip-full \ 
 msmtp \
 libssl-dev \ 
 texinfo  \
 libglib2.0-dev \ 
 xmlto  \
 qemu-utils \ 
 upx \
 libelf-dev \
 autoconf \ 
 automake \
 libtool \
 autopoint \
 device-tree-compiler \
 g++-multilib \
 antlr3 \
 gperf \
 wget \
 swig \
 net-tools \
 openssh-server \
 sudo \
 zsh \
 rsync 


RUN apt-get update && \
        apt-get install -y \
	git \
	build-essential \
	gawk \
	pkg-config \
	gettext \
	automake \
	autoconf \
	autopoint \
	libtool \
	bison \
	flex \
	zlib1g-dev \
	libgmp3-dev \
	libmpfr-dev \
	libmpc-dev \
	texinfo \
	mc \
	libncurses5-dev \
	nano \
	vim \
  	autopoint \
	gperf \
	python-docutils \
	module-init-tools
 
 ##添加padavan部分依赖 部分软件和上述可能相重合

RUN apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get install -y \ 
 unzip libtool-bin curl cmake gperf gawk flex bison nano xxd fakeroot \
 cpio git python-docutils gettext automake autopoint texinfo build-essential help2man \
 pkg-config zlib1g-dev libgmp3-dev libmpc-dev libmpfr-dev libncurses5-dev libltdl-dev wget

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

RUN apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get install -y \ 
 nodejs language-pack-zh-hans

RUN groupadd -g 10000 rock && \
  useradd -r -u 10000 -g rock rock

  ##useradd -u 10000 openwrt

RUN usermod -s /bin/zsh rock
RUN usermod -d /home/rock rock
RUN echo "root:myrock" | chpasswd
RUN echo "rock:myrock" | chpasswd
RUN mkdir -p /var/run/sshd
RUN chmod u+w /etc/sudoers
RUN echo "rock ALL=(ALL:ALL) ALL" >> /etc/sudoers 
RUN chmod u-w /etc/sudoers 
RUN apt-get clean && rm -rf /var/lib/apt/lists
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
ENV LANG zh_CN.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL zh_CN.UTF-8

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]
CMD ["/usr/sbin/sshd", "-D"]
##
USER rock

