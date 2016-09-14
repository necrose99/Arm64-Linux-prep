# Arm64-Linux-prep
docker pre-prep-container for managerial scripts...  , emulation bits. 

#It allows you to run foreign architecture binaries on your host system. 
#For example you can run arm64 binaries on x86_64 linux desktop.
ADD https://raw.githubusercontent.com/mickael-guene/proot-static-build/master-umeq/static/proot-x86_64  /proot
ADD https://github.com/mickael-guene/umeq/releases/download/1.7.4/umeq-arm64  /umeq

My use case was to get Gentoo arm64 and a few emulators as shown above...

however dockerhub the builder slams the door in your face so thus a new docker to make a prep-enviorment.... 
ie just add docker enviorment of target vm , wala Emulation tools for amd64 if needed. 
and a docker arm64.... 
