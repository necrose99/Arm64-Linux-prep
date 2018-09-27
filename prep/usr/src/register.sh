## https://wiki.gentoo.org/wiki/Embedded_Handbook/General/Compiling_with_qemu_user_chroot
## some for the local host some for CHROOT. 
# layman -a hacking-gentoo
### emerge app-emulation/qemu-arm-wrappers on host system/chroot as required. 
###  
echo app-emulation/qemu static-user >> /etc/portage/package.use
#
echo 'QEMU_SOFTMMU_TARGETS="alpha arm i386 mips mips64 mips64el mipsel ppc ppc64 s390x sh4 sh4eb sparc aarch64 sparc64 x86_64"' >> /etc/portage/make.conf
echo 'QEMU_USER_TARGETS="alpha arm armeb i386 mips mipsel ppc ppc64 ppc64abi32 s390x sh4 sh4eb sparc aarch64 sparc32plus sparc64"' >> /etc/portage/make.conf 
#
mkdir /proc/sys/fs/binfmt_misc/
touch /proc/sys/fs/binfmt_misc/register
## Makesure file Exsists. create it if not there 
#
[ -d /proc/sys/fs/binfmt_misc ] || modprobe binfmt_misc
[ -f /proc/sys/fs/binfmt_misc/register ] || mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc 
#
# https://wiki.gentoo.org/wiki/Embedded_Handbook/General/Compiling_with_qemu_user_chroot 
echo ':aarch64:M::\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7:\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/usr/bin/qemu-aarch64:' > /proc/sys/fs/binfmt_misc/register
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/qemu-wrapper:' > /proc/sys/fs/binfmt_misc/register
echo ':armeb:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/usr/bin/qemu-armeb:' > /proc/sys/fs/binfmt_misc/register
echo ':alpha:M::\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x26\x90:\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-alpha:' > /proc/sys/fs/binfmt_misc/register
echo ':mips:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x08:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/usr/bin/qemu-mips:' > /proc/sys/fs/binfmt_misc/register
echo ':mipsel:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x08\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-mipsel:' > /proc/sys/fs/binfmt_misc/register
echo ':ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/usr/bin/qemu-ppc:' > /proc/sys/fs/binfmt_misc/register
echo ':sh4:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2a\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfb\xff\xff\xff:/usr/bin/qemu-sh4:' >/proc/sys/fs/binfmt_misc/register
echo ':sh4eb:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2a:\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/usr/bin/qemu-sh4eb:' >/proc/sys/fs/binfmt_misc/register
echo ':sparc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x02:\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/usr/bin/qemu-sparc:' > /proc/sys/fs/binfmt_misc/register
#
#OpenRC
/etc/init.d/qemu-binfmt start
#Systemd
systemctl restart systemd-binfmt
systemctl status systemd-binfmt
#
#### Install the static qemu into the chroot: 
## failsafe way
### emerge app-emulation/qemu-arm-wrappers on host /Chroot preferable 
# https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Build-aarch64-Packages-on-your-PC%2C-with-User-Mode-QEMU-and-binfmt_misc
cat <<EOF > /qemu-aarch64-wrapper.c
/*
 * Call QEMU binary with additional "-cpu cortex-a53" argument.
 *
 * Copyright (c) 2018 sakaki <sakaki@deciban.com>
 * License: GPL v3.0+
 *
 * Based on code from the Gentoo Embedded Handbook
 * ("General/Compiling_with_qemu_user_chroot")
 */

#include <string.h>
#include <unistd.h>

int main(int argc, char **argv, char **envp) {
	char *newargv[argc + 3];

	newargv[0] = argv[0];
	newargv[1] = "-cpu";
	newargv[2] = "cortex-a53";

	memcpy(&newargv[3], &argv[1], sizeof(*argv) * (argc -1));
	newargv[argc + 2] = NULL;
	return execve("/usr/local/bin/qemu-aarch64", newargv, envp);
}
EOF
### compile that.
gcc -static qemu-aarch64-wrapper.c -O3 -s -o qemu-aarch64-wrapper
