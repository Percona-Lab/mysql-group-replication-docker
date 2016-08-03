#!/bin/bash
set -e

# if command starts with an option, prepend mysqld
if [ "${1:0:1}" = '-' ]; then
	CMDARG="$@"
fi



function join { local IFS="$1"; shift; echo "$*"; }

# Read the list of registered IP addresses
set +e

ipaddr=$(hostname -i | awk ' { print $1 } ')
hostname=$(hostname)
server_id=$(echo $ipaddr | tr . '\n' | awk '{s = s*256 + $1} END{print s}')

exec mysqld --user=root --group_replication_local_address="$ipaddr:6606" --server_id=$server_id --group_replication_ip_whitelist="$ipaddr/8" $CMDARG
