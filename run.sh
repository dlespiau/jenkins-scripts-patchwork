#!/bin/bash -e

originaldir=$PWD
script=$(readlink -f "$0")
scriptdir=$(dirname "$script")

setup_git_socks_proxy()
{
	[ -z "$SOCKS_PROXY_SERVER" -o -z "$SOCKS_PROXY_PORT" ] && return 0

	nc --version 2>&1 | grep nmap > /dev/null
	if [ "$?" = 0 ]; then
		nc_type=nmap
	else
		nc_type=bsd
	fi

	export GIT_PROXY_COMMAND=$scriptdir/bin/git-proxy-$nc_type
}

update_virtualenv()
{
	directory=$1
	requirements=$2

	cd $scriptdir
	[ -d "$directory" ] || virtualenv "$directory"
	source $directory/bin/activate
	pip install -r $requirements
	cd $originaldir
}

update_virtualenv env requirements.txt
tox --recreate
./tests/test_js.sh
./tests/test_pep8.sh
deactivate
