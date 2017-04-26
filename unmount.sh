#!/bin/bash

count=0
for arg in `diskutil info -all | grep 'Volume Name' | cut -d : -f 2 | sed 's/^[[:space:]]*//' | sed 's/[ \t]*$//g'`
do
  volume_names[$count]=$arg
  count=`expr $count + 1`
done


#if [ $# != 1 ]; then
#	echo "error!!"
#	echo "Usage: ntfsunmount [disk_name]"
#	exit -1
#fi

tLen=${#volume_names[@]}
echo $tLen

for (( i=0; i<${tLen}; i++ ));
do
	echo ${volume_names[$i]}
    disk_name=${volume_names[$i]}
	device_node=`diskutil info ${disk_name} | grep 'Device Node' | cut -d : -f 2 | sed 's/^[[:space:]]*//' | sed 's/[ \t]*$//g'`

	mounted_path="/Volumes/${disk_name}"

	sudo diskutil unmount "${mounted_path}"

	link_path=~/Desktop/${disk_name}
	echo ${link_path}
	if [ ! -L ${link_path} ]; then
		echo "link path ${link_path} not exist"
		#exit 0
		continue
	else
		echo "remove link file"
		rm ${link_path}
		#exit 0
		continue
	fi
done