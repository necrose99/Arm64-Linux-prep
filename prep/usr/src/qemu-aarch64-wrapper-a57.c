/*
 * Call QEMU binary with additional "-cpu cortex-a57" argument.
 *
 * Copyright (c) 2018 sakaki <sakaki@deciban.com> , moded by necrose99 for added cpu types
 * can set the real wrapper by symlink... a57 can use lager swaths of ram.
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
	newargv[2] = "cortex-a57";

	memcpy(&newargv[3], &argv[1], sizeof(*argv) * (argc -1));
	newargv[argc + 2] = NULL;
	return execve("/usr/local/bin/qemu-aarch64", newargv, envp);
}
