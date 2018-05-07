#!/usr/bin/env bash
CURRENT_DIR=$(pwd)

SAVEBACKPATH="/opt/wisecloud/cdn/rvmanage/rvmanage_server_bak"
# 读取数据库配置，备份数据库

RVMANAGESERVERPATH="/opt/wisecloud/cdn/rvmanage/rvmanage_server"

INSTALL_LOG="/tmp/rvmanage_install.log"
DATAPATH="/opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/utils/lib"
SAVEBAKSQL="/opt/wisecloud/cdn/rvmanage/rvmanage_server_bak/software/rvmanage/utils/lib/rvdb.sql"
LAST_VERSION=`grep "Version" ${RVMANAGESERVERPATH}/version | awk -F '=' '{print $2}'`


export INSTALL_LOG
if [ -d ${SAVEBACKPATH} ];then
	CURRENT_VERSION=`grep "Version" ${SAVEBACKPATH}/version  | awk -F '=' '{print $2}'`
	DBNAME=$(grep 'db_database' ${SAVEBACKPATH}/param.properties | cut -d'=' -f2)
	DBTYPE=$(grep 'd_type' ${SAVEBACKPATH}/param.properties | cut -d'=' -f2)
	USERNAME=$(grep 'db_username' ${SAVEBACKPATH}/param.properties | cut -d'=' -f2)
	PASSWORD=$(grep 'db_password' ${SAVEBACKPATH}/param.properties | cut -d'=' -f2)
	HOST=$(grep 'db_host' ${SAVEBACKPATH}/param.properties | cut -d'=' -f2)
	PORT=$(grep 'db_port' ${SAVEBACKPATH}/param.properties | cut -d'=' -f2)
    # 数据回滚（数据库结构保持不变的情况下）    
    if [ -f ${SAVEBAKSQL} ];then        # 备份数据库 
        PGPASSWORD=${PASSWORD} pg_dump -h ${HOST} -p ${PORT} -U ${USERNAME} ${DBNAME} >${DATAPATH}/rvdb.sql >/dev/null 2>&1        
        if [ $? -ne 0 ]; then  
			echo -e "\033[31;49;1m [----------无法导出sql，备份数据库失败--------] \033[39;49;0m"
            exit 1
        fi
        PGPASSWORD=${PASSWORD} psql -U ${USERNAME} -h ${HOST} -p ${PORT} <${SAVEBAKSQL} >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "\033[31;49;1m [----------回滚数据库失败--------] \033[39;49;0m"
            echo "-----------`date` 回退数据库失败--------------" >> ${INSTALL_LOG} 2>&1
            exit 1
        else
		
            echo -e "\033[32;49;1m [-----------回滚数据库成功-------] \033[39;49;0m"
            echo "-----------`date` 回退数据库成功--------------" >> ${INSTALL_LOG} 2>&1
        fi
    #  程序回滚
    #yes|cp -rf ${DATAPATH} ${SAVEBACKPATH} >/dev/null 2>&1
    rm -rf ${RVMANAGESERVERPATH};mv ${SAVEBACKPATH} ${RVMANAGESERVERPATH}
    fi
    echo -e "\033[32;49;1m [-----------------Current Version:${CURRENT_VERSION} Last Version:${LAST_VERSION}---------------] \033[39;49;0m"
    echo "-----------`date` Current Version:${CURRENT_VERSION} Last Version:${LAST_VERSION}--------------" >> ${INSTALL_LOG} 2>&1
    exit 0
else
    echo -e "\033[31;49;1m [----------没发现回滚版本，回滚失败--------] \033[39;49;0m"
    exit 1
fi
