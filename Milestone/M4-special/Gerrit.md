### Gerrit
Gerrit is a free, web-based collaborative code review tool that integrates with Git. It has been developed at Google by Shawn Pearce (co-author of Git, founder of JGit) for the development of the Android project.

#### Usage
Set up Git

	sudo apt-get install git
	git config --global user.email "fwang12@ncsu.edu"
	git config --global user.name "feifeiwang7"

Set up SSH Keys in Gerrit

	cd ~/.ssh
	ssh-keygen -t rsa -C "fwang12@ncsu.edu"
	cat ~/.ssh/id_rsa.pub

Add ssh key to your gerrit account

	create an account at https://wikitech.wikimedia.org/wiki/Special:UserLogin/signup
	Log into https://gerrit.wikimedia.org/
	Click on your username in the top right corner, then choose "Settings"
	On the left you will see SSH PUBLIC KEYS, and add your key there.

Add ssh key to use with git

	eval `ssh-agent`
	ssh-add ~/.ssh/id_rsa
	ssh -p 29418 feifeiwang7@gerrit.wikimedia.org
It should give a Gerrit welcome message and then abort.


#### Reference
http://www.mediawiki.org/wiki/Gerrit/Tutorial
