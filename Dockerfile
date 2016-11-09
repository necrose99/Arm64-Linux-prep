FROM busybox
MAINTAINER Necrose99
#ENV ARCH=arm64
#Umeq is an equivalent of Qemu user mode. 
#It allows you to run foreign architecture binaries on your host system. 
#For example you can run arm64 binaries on x86_64 linux desktop.
ADD https://github.com/necrose99/Arm64-Linux-prep/blob/master/prep.zip /
# add the tooys/tools etc.
ADD https://raw.githubusercontent.com/mickael-guene/proot-static-build/master-umeq/static/proot-x86_64  /proot
ADD https://github.com/mickael-guene/umeq/releases/download/1.7.4/umeq-arm64  /umeq
RUN chmod +x {/proot-start.sh, /umeq, /proot}
#
VOLUME /var/lib/layman:rw, /usr/portage:rw", /usr/portage/distfiles:rw, /packages:rw, /:rw


RUN mkdir /usr/portage && rmdir /usr/portage/packages && ln -s /packages /usr/portage/packages 
# less digging latter if pushing packages out of docker to Binhost. 
#make easy 4 laterz with lazy sym-links.
RUN ln -s /proot-start.sh /proot-start 
#RUN ln -s /umeq-arm64 /umeq  
#RUN ln -s /proot-x86_64 /proot
