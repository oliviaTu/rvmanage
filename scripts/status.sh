#!/bin/sh

ver_conf=/opt/wisecloud/cdn/rvmanage/rvmanage_server/version
INSTALL_DIR=/opt/wisecloud/cdn/rvmanage/rvmanage_server

RED_COLOR='\E[31m'
GREEN_COLOR='\E[32m'
RES='\E[0m'

log_info() {
    echo -e "${GREEN_COLOR}$1${RES}"
}

log_warning() {
    echo -e "${RED_COLOR}$1${RES}"
}

log_info "[-----ProductName:$(head -n1 ${ver_conf} | tail -n1 | cut -d'=' -f2)-----]"
log_info "[-----ProductVersion:$(head -n2 ${ver_conf} | tail -n1 | cut -d'=' -f2)-----]"
log_info "[-----ProductProvider:$(head -n3 ${ver_conf} | tail -n1 | cut -d'=' -f2)-----]"
log_info "[-----CreateTime:$(head -n4 ${ver_conf} | tail -n1 | cut -d'=' -f2)-----]"
num=$(ps -ef |grep /opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/rvmanage | grep -v grep)

if [ "${num}" ]; then
    log_info "[-----Server status:started-----]"
else
    log_warning "[-----Server status:stopped-----]"
fi
