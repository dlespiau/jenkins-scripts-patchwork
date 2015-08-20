Jenkins Patchwork Scripts
=========================

This repository contains Jenkins scripts used to monitor the health of
[patchwork](http://jk.ozlabs.org/projects/patchwork/)


Installation
------------

One of the design goals is to have a minimal script specified in Jenkins and
most of the code maintained in this repository. The jenkins side should also be
able to automatically update these scripts without human intervention.
Something like the below should do:

```shell
update_tree()
{
	directory=$1
	git_url=$2

	[ -d "$directory" ] && {
		cd "$directory"
		git fetch
		git reset --hard origin/master
		cd -
		return 0
	}

	git clone $git_url "$directory"
}

dir=.jenkins_scripts
update_tree $dir git://github.com/dlespiau/jenkins-scripts-patchwork.git
./$dir/run.sh

```
