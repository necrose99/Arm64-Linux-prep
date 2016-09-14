# proot-start.sh  ,
# Supporting crossbuilding etc with qemu-aarch64-binfmt (qemu-aarch64-userstatic) also umeq is a micro qemu static.
# however QEMU may yeild more stability however for cloud use ie dockerhub to build I'll invoke via script... 
cwd=$(pwd)
echo "Arm64 from AMD-64 what sorcery is this ?
echo "fire in the hole the chroot cometh"
## do chroot and load static emulation binformat etc.. 
#./$cwd/proot -R $cwd/ -q  ./umeq bash
proot -R / -q ./umeq-arm64 bash
#
#type in "uname -m" or unmae -a 
sorcery () {
uname -a && ls --color -lah 
echo " sorcery I tell you ?
echo "Bootstrapped  into chroot/proot  gentoo-arm64:"
emerge-webrsync 
# populate the portage volume with ebuilds etc. 
}
hotsause () {
  mkdir /etc/binfmt.d/
# Supporting crossbuilding with binfmt
cat >> /etc/binfmt.d/qemu-arm64.conf <<EOF
# AArch64 binaries.
:qemu-arm64:M::\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/qemu-arm64:OC
EOF
# Supporting crossbuilding etc with qemu-aarch64-binfmt (qemu-aarch64-userstatic) also umeq is a micro qemu static.

# Setup the rc_sys
sed -e 's/#rc_sys=""/rc_sys="lxc"/g' -i /etc/rc.conf
}
