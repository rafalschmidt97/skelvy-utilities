#!/bin/bash
# source http://stackoverflow.com/questions/23222616/copy-all-keys-from-one-db-to-another-in-redis
#set connection data accordingly
source_host=skelvy-api-redis.redis.cache.windows.net
source_port=6379
source_password=5DhmfjiziJykOdg7FGznSF9rMD3eLDEG80fheHvjDHg=
target_host=ec2-63-32-83-204.eu-west-1.compute.amazonaws.com
target_port=6379
target_password=pa59081765d0edf264c03de42b3a881cf2117c534cc5088da99bfc972ac65b77c

#copy all keys without preserving ttl!
redis-cli -h $source_host -p $source_port -a $source_password keys \* | while read key;
do
    echo "Copying $key"
    redis-cli --raw -h $source_host -p $source_port -a $source_password DUMP "$key" | ghead -c -1 | redis-cli -x -h $target_host -p $target_port -a $target_password RESTORE "$key" 0
done
