#!/bin/bash -e

if [ $# -ne 2 ]; then
	echo "Error: Missing arguments uid and gid!"
	echo "Maybe you forgot to pass <uid> <gid> to docker run?"
	exit 1
fi

_UID=$1
_GID=$2

# create build user (and group if it does not exist)
groupadd -g $_GID build 2>/dev/null || true
useradd -s /bin/bash -u $_UID -g $_GID -d /src build

# now spawn an interactive shell as the build user
su - build
exit $?
