#!/bin/sh
num=$(ps -ef |grep /opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/rvmanage | grep -v grep)
if [ "$num" ]; then
	echo "rvmanage is running"
	exit 0
fi

prog_path=/opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/rvmanage
nohup ${prog_path} > /opt/wisecloud/cdn/rvmanage/run/rvmanageout.file 2>&1 &
if [ $? -ne 0 ]
then
	echo "start rvmanage failed"
else
	echo "start rvmanage success"
fi