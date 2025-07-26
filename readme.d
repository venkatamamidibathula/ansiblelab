# This lab setup provides a setup for seamless setup of ansible master and worker nodes.

Both the master and worker nodes are docker containers and it will help kickstart your ansible journey without much hassle.

Define your playbook in ansible roles and run the below commands first time in sequence order.

**Worker nodes should be up first**

- docker-compose up -d worker-node1
- docker-compose up -d worker-node2

**Once the worker nodes are up, anytime you wish to run the playbooks, execute the below steps in sequential order**.
- docker-compose build ansible-master
- docker-compose run ansible-master




**Note** : This is for home lab setup on any linux machine.


