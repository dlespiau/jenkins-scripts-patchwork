#!/bin/bash -e

originaldir=$PWD
script=$(readlink -f "$0")
scriptdir=$(dirname "$script")

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
tox
deactivate
