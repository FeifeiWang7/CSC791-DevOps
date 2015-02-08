Build Server Using Jenkins (some of the descriptions are copied from workshop, and the starting part is cooperated with Jesse)

### Install  Jenkins (from https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu)
1. Installation:
	wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
	sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
	sudo apt-get update
	sudo apt-get install jenkins
2. Upgrade:
	sudo apt-get update
	sudo apt-get install jenkins
3. Config Jenkins to make it accessable at localhost:8181
4. In the 'Manage Jenkins' -> 'Manage Plugins' tab, download plugins related to git to enable github hook

### Config Github
1. Create a github repo for testing, e.g., 'MavenExample'.
2. Enable jenkins in 'MavenExample' by Settings -> Webhooks & Services -> Add Service -> Select Jenkins (Github plugin) -> Jenkins hook url: http://152.14.93.228:8181/github-webhook

###Build Master and Slave Vagrant Machine (from workshop2)
1. Create a 64-bit VM:
	vagrant init hashicorp/precise64
Init should initiatiate a download of the box, if not, manually add it as follows:
	vagrant box add precise32 http://files.vagrantup.com/precise32.box
2. Config public network and forwarded port:
	vim Vagrantfile
	config.vm.network "forwarded_port", guest: 6060, host: 6767
	config.vm.network "forwarded_port", guest: 8080, host: 8181
3. Config private network for host-only access to the machine:
	config.vm.network "private_network", ip: "192.168.33.11"
4. Config bridged network:
	config.vm.network "public_network"
5. No passward for jenkins when using SSH:
	sudo vim /etc/sudoers
	jenkins ALL= NOPASSWD: ALL
6. Start up the VM:
	vagrant up
	vagrant ssh
7. Repeat the above steps to create the slave, except that the public network is disabled and the ip address for slave is "192.168.33.22".

###Install Docker in Master and Slave (from workshop3-build)
1. Install the backported kernel:
	sudo apt-get update
	sudo apt-get -y install linux-image-generic-lts-raring linux-headers-generic-lts-raring
	sudo reboot
2. Add the repository to the APT sources:
	sudo sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
3. Import the repository key:
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
4. Install docker:
	sudo apt-get update
	sudo apt-get install -y lxc-docker
5. Install some basic tools:
	sudo apt-get -y install git vim
6. Build a docker environment for running build. Create a "Dockerfile" and place this inside:
	FROM ubuntu:13.10
	MAINTAINER Chris Parnin, chris.parnin@ncsu.edu
    
	RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main universe" > /etc/apt/sources.list
	RUN apt-get -y update && apt-get -y upgrade
	RUN apt-get install -y wget openjdk-7-jdk curl unzip

	RUN apt-get -y install git
	RUN apt-get -y install maven
	RUN apt-get -y install libblas*
	RUN ldconfig /usr/local/cuda/lib64
    
	ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
7. Build the docker image:
	sudo docker build -t ncsu/buildserver .
8. Test the image:
	sudo docker images
	sudo docker run -it ncsu/buildserver mvn --version
9. In the VM, create 'build.sh' and place the following inside: 
	git clone https://github.com/jessexu20/MavenExample
	cd MavenExample/my-app
	mvn clean 
	mvn package
10. Put the script in the configure of the build example 'MavenExample':
	chmod +x build.sh
	sudo docker run -v /home/vagrant/:/vol ncsu/buildserver sh -c /vol/build.sh

### Check
Now it should be able to:
1. Trigger a build in response to a git commit via a git hook.
2. Setup dependencies for the project and restore to a clean state.
3. Execute a build script (e.g., shell, maven)
4. Retrieve the status of the build via http.

To run a build on multiple nodes (e.g. jenkins slaves, go agents, or a spawned droplet/AWS.), I need to config the slave.

### Config Slave Build Server
1. Enable connection between master and slave:
	ssh-keygen -t dsa (on master)
2. Copy ~/.ssh/id_dsa.pub on master to .ssh/authorized_keys on the slave machine
3. Config the credentials on Jenkins for the slave node to be the private key (copy the file instead of choosing find from ~/.ssh because by default Jenkins uses id_rsa not id_dsa)
4. try ssh from master to slave to see if the connection is successful
