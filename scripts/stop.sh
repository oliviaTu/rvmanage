#!/bin/sh

ps -ef | grep /opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/rvmanage | grep -v grep | awk '{print $2}' | xargs kill -9