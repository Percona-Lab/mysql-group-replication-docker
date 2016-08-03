Start the first node:

    docker run -d --net=cluster1 --name=node1  perconalab/mysql-group-replication --group_replication_bootstrap_group=ON

Start thefollowing nodes:

    docker run -d --net=cluster1 --name=node2  perconalab/mysql-group-replication --group_replication_group_seeds='node1:6606' 

It is a good idea to create a docker network in advance:

    docker network create cluster1
