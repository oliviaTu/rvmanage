#!/usr/bin/env bash

INSTALL_LOG="/tmp/RVmanageServer_install.log"
export INSTALL_LOG

CURRENT_DIR=$(pwd)
DATAPATH="/opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/utils/lib"
RVMANAGESERVERPATH="/opt/wisecloud/cdn/rvmanage/rvmanage_server"
SAVEBACKPATH="/opt/wisecloud/cdn/rvmanage/rvmanage_server_bak"

PARAMNUM=$#
INSTALL_MODE=$1
ISSTART=$2
FPAR=$3
PARAMSPATH=$4

# 读取数据库配置，备份数据库
DB_USERNAME=$(grep 'db_username' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
DB_PASSWORD=$(grep 'db_password' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
DB_DATABASE=$(grep 'db_database' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

D_TYPE=$(grep 'd_type' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
DB_POOL_SIZE=$(grep 'db_pool_size' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
DB_HOST=$(grep 'db_host' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
DB_PORT=$(grep 'db_port =' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

dbip=$(grep 'dbip' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
usrid=$(grep 'usrid' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
logpasswd=$(grep 'passwd' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
logdbport=$(grep 'dbport' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
logdbname=$(grep 'logdbname' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

log_conf_path=$(grep 'log_conf_path' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
log_db_path=$(grep 'log_db_path' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

cas_operator_search=$(grep 'cas_operator_search ' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
key=$(grep 'key' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
cas_host=$(grep 'cas_host' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
cas_port=$(grep 'cas_port' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
cas_password=$(grep 'cas_password' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

cas_log_path=$(grep 'cas_log_path' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

cas_conf_path=$(grep 'cas_conf_path' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
cas_lib_path=$(grep 'cas_lib_path' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
rvlss_addr=$(grep 'rvlss_addr' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

num=$(grep 'num' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
sleep_time=$(grep 'sleep_time' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

modify_config()
{
    # 修改rvmanage配置文件
    sed -i "s/db_username_v/$DB_USERNAME/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s/db_password_v/$DB_PASSWORD/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s/db_database_v/$DB_DATABASE/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s/d_type_v/$D_TYPE/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s/db_pool_size_v/$DB_POOL_SIZE/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s/db_host_v/$DB_HOST/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s/db_port_v/$DB_PORT/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
	
	sed -i "s%log_conf_path_v%$log_conf_path%g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s%log_db_path_v%$log_db_path%g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini

	sed -i "s/cas_operator_search_v/$cas_operator_search/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s/key_v/$key/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s%cas_log_path_v%$cas_log_path%g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
	
    sed -i "s%cas_conf_path_v%$cas_conf_path%g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s%cas_lib_path_v%$cas_lib_path%g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini

    sed -i "s/rvlss_addr_v/$rvlss_addr/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s/num_v/$num/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini
    sed -i "s/sleep_time_v/$sleep_time/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/conf.ini

    sed -i "s/192.168.10.171/$cas_host/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/casclient/casclient.ini
    sed -i "s/6379/$cas_port/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/casclient/casclient.ini
    sed -i "s/wisecloud/$cas_password/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/casclient/casclient.ini

    sed -i "s/192.168.10.146/$dbip/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf
    sed -i "s/postgres/$usrid/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf
    sed -i "s/123/$logpasswd/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf
    sed -i "s/5432/$logdbport/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf
    sed -i "s/rvdb/$logdbname/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf

}

modify_cas_conf()
{
    #修改cas配置
    casformer_host=$(grep 'host' ${RVMANAGESERVERPATH}/software/rvmanage/utils/casclient/casclient.ini | cut -d':' -f2)
    casformer_port=$(grep 'port' ${RVMANAGESERVERPATH}/software/rvmanage/utils/casclient/casclient.ini | cut -d':' -f2)
    casformer_passwd=$(grep 'password' ${RVMANAGESERVERPATH}/software/rvmanage/utils/casclient/casclient.ini | cut -d':' -f2)
    cas_host=$(grep 'cas_host' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

    sed -i "s/$casformer_host/$cas_host/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/casclient/casclient.ini
    sed -i "s/$casformer_port/$cas_port/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/casclient/casclient.ini
    sed -i "s/$casformer_passwd/$cas_password/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/casclient/casclient.ini
}

modify_log()
{
    #---修改操作日志配置-----
    dbipformer=$(grep 'dbip' ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf | cut -d'=' -f2)
    usridformer=$(grep 'usrid' ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf | cut -d'=' -f2)
    passwdformer=$(grep 'passwd' ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf | cut -d'=' -f2)
    dbportformer=$(grep 'dbport' ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf | cut -d'=' -f2)
    logdbnameformer=$(grep 'logdbname' ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf | cut -d'=' -f2)
    
    dbip=$(grep 'dbip' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
    usrid=$(grep 'usrid' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
    passwd=$(grep 'passwd' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
    dbport=$(grep 'dbport' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
    logdbname=$(grep 'logdbname' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
    
    
    sed -i "s/$dbipformer/$dbip/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf
    sed -i "s/$usridformer/$usrid/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf
    sed -i "s/$passwdformer/$passwd/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf
    sed -i "s/$dbportformer/$dbport/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf
    sed -i "s/$logdbnameformer/$logdbname/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/logsuite/logdb.conf
}



#修改authcenter配置
modify_auth_conf()
{
    auth_former_ip=$(grep 'ip' ${RVMANAGESERVERPATH}/software/rvmanage/utils/authclient/licenseclient.conf | cut -d'=' -f2)
    auth_former_port=$(grep 'port' ${RVMANAGESERVERPATH}/software/rvmanage/utils/authclient/licenseclient.conf | cut -d'=' -f2)
    auth_former_url=$(grep 'url' ${RVMANAGESERVERPATH}/software/rvmanage/utils/authclient/licenseclient.conf | cut -d'=' -f2)

    auth_ip=$(grep 'auth_ip' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
    auth_port=$(grep 'auth_port' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)
    auth_url=$(grep 'auth_url' ${CURRENT_DIR}/param.properties | cut -d'=' -f2)

    sed -i "s/$auth_former_ip/$auth_ip/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/authclient/licenseclient.conf
    sed -i "s/$auth_former_port/$auth_port/g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/authclient/licenseclient.conf
    sed -i "s%auth_former_url%$auth_url%g" ${RVMANAGESERVERPATH}/software/rvmanage/utils/authclient/licenseclient.conf

}


# 检查环境
check_env()
{
	# 删除安装日志文件
	rm -rf ${INSTALL_LOG} >/dev/null 2>&1

	echo -e "\033[32;49;1m [----------------check env begin--------------] \033[39;49;0m"
	echo "`date` check env begin--------------" >> ${INSTALL_LOG} 2>&1
	
    # 检查是否已经安装rvmanageServer,如果存在,先执行stop.sh脚本
    if [ -d ${RVMANAGESERVERPATH} ]; then
		echo "`date` Start to stop rvmanageServer service." >> ${INSTALL_LOG} 2>&1
	  
		# 检查rvmanage_server服务是否已经启动
		process=`ps -ef |grep rvmanage |grep -v "grep" |grep -v "start" |grep -v "stop" |grep -v "status" |wc -l`
		if [ ${process} == 1 ]; then
			stop_rvmanageServer >> ${INSTALL_LOG} 2>&1
		fi

    fi
    echo -e "\033[32;49;1m [-----------------check env end---------------] \033[39;49;0m"
    echo "`date` check env end--------------" >> ${INSTALL_LOG} 2>&1
}


pwd
mkdir -p /opt/wisecloud/cdn/rvmanage/run
# 注册命令
register_cmd()
{
    #注册restart命令
	chmod +x ${CURRENT_DIR}/scripts/*
    yes|cp ${CURRENT_DIR}/scripts/restart.sh /bin/restart_rvmanageServer
    chmod 755 /bin/restart_rvmanageServer

    #注册查看状态命令status
	yes|cp ${CURRENT_DIR}/scripts/status.sh /bin/status_rvmanageServer
    chmod 755 /bin/status_rvmanageServer

	#注册start命令
	yes|cp ${CURRENT_DIR}/scripts/start.sh /bin/start_rvmanageServer
    chmod 755 /bin/start_rvmanageServer

    #注册stop命令
	yes|cp ${CURRENT_DIR}/scripts/stop.sh /bin/stop_rvmanageServer
    chmod 755 /bin/stop_rvmanageServer

    #注册stop命令
	yes|cp ${CURRENT_DIR}/scripts/rollback.sh /bin/rollback_rvmanageServer
    chmod 755 /bin/rollback_rvmanageServer
}

# 备份数据
backup()
{
    echo -e "\033[32;49;1m [----------------backup database begin--------------] \033[39;49;0m"
    echo "`date` backup database begin--------------" >> ${INSTALL_LOG} 2>&1
    #先删除存在的数据库
    #su postgres -c "PGPASSWORD=${DB_PASSWORD} psql -h ${DB_HOST} -p ${DB_PORT} -c ' DROP DATABASE ${DB_DATABASE}'"
    # 创建数据库
    #su postgres -c "PGPASSWORD=${DB_PASSWORD} psql -h ${DB_HOST} -p ${DB_PORT} -c ' CREATE DATABASE ${DB_DATABASE}'"

    if [ -d ${DATAPATH} ];then
        # 备份数据库
        touch ${DATAPATH}/rvdb.sql
        PGPASSWORD=${DB_PASSWORD} pg_dump -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USERNAME} ${DB_DATABASE}>${DATAPATH}/rvdb.sql
        if [ $? -ne 0 ]; then
            echo -e "\033[31;49;1m [----------无法导出sql，备份数据库失败--------] \033[39;49;0m"
            exit 1
        fi
    else
        echo -e "\033[31;49;1m [----------data目录不存在，备份数据库失败--------] \033[39;49;0m"
        exit 1
    fi

    echo -e "\033[32;49;1m [----------------backup database end--------------] \033[39;49;0m"
    echo "`date` backup database end--------------" >> ${INSTALL_LOG} 2>&1
}

# 检查组件安装环境
check_components_env()
{
    echo -e "\033[32;49;1m [----------------check components environment begin--------------] \033[39;49;0m"
    echo "`date` check components environment begin--------------" >> ${INSTALL_LOG} 2>&1
    lib_path=${CURRENT_DIR}/software/rvmanage/utils/lib
	chmod +x ${lib_path}/*
    if [ -d ${lib_path} ];then
        chmod -R 755 ${lib_path}
        # yes|cp ${lib_path}/libhiredis.so /usr/lib
        # yes|cp ${lib_path}/libjson.so /usr/lib
        # yes|cp ${lib_path}/liblogsuite.so.1.1.6 /usr/lib
        # yes|cp ${lib_path}/libcas.so.1.1.4 /usr/lib
        #yes|cp ${lib_path}/liblicenseClient.so /usr/lib

        if [ ! -f /usr/lib/liblogsuite.so ];then
            ln -s /usr/lib/liblogsuite.so.1.1.6 /usr/lib/liblogsuite.so
        fi

        if [ ! -f /usr/lib/libcas.so ];then
            ln -s /usr/lib/libcas.so.1.1.4 /usr/lib/libcas.so
        fi

        if [ ! -f /usr/lib/liblicenseClient.so ];then
            ln -s /usr/lib/liblicenseClient.so /usr/lib/liblicenseClient.so
        fi

        if [ ! -f /usr/lib/libhiredis.so ];then
            ln -s /usr/lib/libhiredis.so /usr/lib/libhiredis.so
        fi

        if [ ! -f /usr/lib/libjson.so ];then
            ln -s /usr/lib/libjson.so /usr/lib/libjson.so
        fi

        if [ ! -f /usr/lib/libcas.so ];then
            ln -s /usr/lib/libcas.so /usr/lib/libcas.so
        fi

        ldconfig
    fi


    echo -e "\033[32;49;1m [----------------check components environment end--------------] \033[39;49;0m"
    echo "`date` check components environment end--------------" >> ${INSTALL_LOG} 2>&1
}

# 全量安装
all_install()
{
    echo "-----------`date` install rvmanage begin--------------" >> ${INSTALL_LOG} 2>&1
    echo -e "\033[32;49;1m [-----------install rvmanage begin------------] \033[39;49;0m"
    # 检查安装环境
	check_env
	check_components_env


    # 注册命令
    register_cmd


	# 备份目录
    if [ -d ${RVMANAGESERVERPATH} ];then
        #if [ ! -d ${DATAPATH} ];then
            #mkdir -p ${DATAPATH}
        #fi
        rm -rf ${SAVEBACKPATH};mv ${RVMANAGESERVERPATH} ${SAVEBACKPATH}
    else
        rm -rf ${SAVEBACKPATH}>/dev/null 2>&1
    fi

	cp -rf ${CURRENT_DIR} /opt/wisecloud/cdn/rvmanage/rvmanage_server
    if [ ! -d ${DATAPATH} ];then
        mkdir -p ${DATAPATH}
    fi
    #backup

    # 删除旧的数据库
    su postgres -c "PGPASSWORD=${DB_PASSWORD} psql -h ${DB_HOST} -p ${DB_PORT} -c ' DROP DATABASE ${DB_DATABASE}'" >/dev/null 2>&1

    echo "`date` Initialization database--------------" >> ${INSTALL_LOG} 2>&1;
    echo -e "\033[32;49;1m [-----------Initialization database-------] \033[39;49;0m"
    # 创建新数据库
    su postgres -c "PGPASSWORD=${DB_PASSWORD} psql -h ${DB_HOST} -p ${DB_PORT} -c 'CREATE DATABASE ${DB_DATABASE}'">/dev/null 2>&1
    #PGPASSWORD=${DB_PASSWORD} su postgres -c "createdb -h ${DB_HOST} -p ${DB_PORT} ${DB_DATABASE}" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "\033[31;49;1m [----------创建数据库失败--------] \033[39;49;0m"
        exit 1
    fi

    # 初始化数据库
    if [ ! -f ${CURRENT_DIR}/software/rvmanage/utils/lib/rvdb.sql ];then
        echo -e "\033[31;49;1m [----------rvdb.sql不存在，初始化数据库失败--------] \033[39;49;0m"
        exit 1
    fi
    PGPASSWORD=${DB_PASSWORD} psql -U ${DB_USERNAME} -d ${DB_DATABASE} -h ${DB_HOST} -p ${DB_PORT} -f ${CURRENT_DIR}/software/rvmanage/utils/lib/rvdb.sql  >/dev/null 2>&1

    # 修改rvmanageServer配置文件
    modify_config
    modify_cas_conf
    modify_auth_conf
    modify_log
    yes|cp ${PARAMSPATH} /opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/utils/conf.ini
    chmod 755 ${RVMANAGESERVERPATH}/software/rvmanage/*

    echo "-----------install software end--------------" >> ${INSTALL_LOG} 2>&1
    echo -e "\033[32;49;1m [-----------install software finished---------] \033[39;49;0m"
}

# 增量安装
update_install(){
    echo "-----------`date` install software begin--------------" >> ${INSTALL_LOG} 2>&1
    echo -e "\033[32;49;1m [-----------install software begin------------] \033[39;49;0m"
    # 检查安装环境
    #checkEnv

    #检查组件安装环境
    #check_components_env

    if [ -d ${RVMANAGESERVERPATH} ];then
        if [ ! -d ${SAVEBACKPATH} ];then
            mkdir -p ${SAVEBACKPATH}
        fi
        #  将上一版本设为回退版本
        rm -rf ${SAVEBACKPATH};mv ${RVMANAGESERVERPATH} ${SAVEBACKPATH}

        cp -rf ${CURRENT_DIR} ${RVMANAGESERVERPATH}
        yes |cp -rf ${SAVEBACKPATH}/software/rvmanage/utils/authclient  ${RVMANAGESERVERPATH}/software/rvmanage/utils/

        #yes|cp -rf ${SAVEBACKPATH}/data ${RVMANAGESERVERPATH}>/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "\033[31;49;1m [----------11拷贝data目录失败--------] \033[39;49;0m"
            exit 1
        fi

        #yes|cp -rf ${SAVEBACKPATH}/software/logsuite ${RVMANAGESERVERPATH}/software >/dev/null 2>&1
        #yes|cp -rf ${SAVEBACKPATH}/software/conf.ini ${RVMANAGESERVERPATH}/software >/dev/null 2>&1
        
        if [ $? -ne 0 ]; then
            echo -e "\033[31;49;1m [----------拷贝组件目录失败--------] \033[39;49;0m"
            exit 1
        fi
    else
        cp -rf ${CURRENT_DIR} ${RVMANAGESERVERPATH}
        if [  ! -d ${DATAPATH} ];then
            mkdir -p ${DATAPATH}
        fi
        #  将上一版本设为回退版本
        rm -rf ${SAVEBACKPATH};cp -rf ${RVMANAGESERVERPATH} ${SAVEBACKPATH}
    fi

    # 备份数据数据库
    #backup

    chmod 755 ${RVMANAGESERVERPATH}/software/rvmanage/*
	cp -rf ${SAVEBACKPATH}/software/rvmanage/utils/conf.ini  ${RVMANAGESERVERPATH}/software/rvmanage/utils/
	
    #更新配置文件
	yes|cp ${PARAMSPATH} /opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/utils/conf.ini
	modify_cas_conf
    modify_auth_conf
    modify_log

    echo "-----------`date` install software finished--------------" >> ${INSTALL_LOG} 2>&1
    echo -e "\033[32;49;1m [-----------install software finished------------] \033[39;49;0m"
}

# 判断启动参数
if [ "$PARAMNUM" -ne "4" ];then
    echo "-[i|u] \"-i: 全量安装    -u: 增量安装\""
    echo "-[s|n] \"-s: 安装完成后启动应用程序    -n: 安装完成后不启动应用程序\""
	echo "-f     \"param.properties文件的绝对路径\""
	echo "demo: sh setup.sh -i -n -f \`pwd\`/param.properties"
    exit 1
fi

if [ "$INSTALL_MODE" != "-i" ] && [ "$INSTALL_MODE" != "-u" ]; then
    echo "第1个参数必须是 -i 或者 -u"
    exit 1
fi

if [ "$ISSTART" != "-n" ] && [ "$ISSTART" != "-s" ]; then
    echo "第2个参数必须是 -s 或者 -n"
    exit 1
fi
if [ "$FPAR" != "-f" ]; then
    echo "第3个参数必须是 -f"
    exit 1
fi

if [ "$INSTALL_MODE" == "-i" ];then
    echo "你确定要全量安装吗？全量安装将会清除所有数据，请考虑清楚后做操作！输入：yes 继续，否则安装终止"
    read answer
    if [ "$answer" == "yes" ];then
        echo "请再次确认是否选择全量安装！输入：yes 继续，否则安装终止"
        read answer
        if [ "$answer" != "yes" ];then
            echo -e "\033[32;49;1m [-----------install terminated...------------] \033[39;49;0m"
            exit 0
        else
            all_install
        fi
    else
        echo -e "\033[32;49;1m [-----------install terminated...------------] \033[39;49;0m"
        exit 0
    fi
fi

if [ "$INSTALL_MODE" == "-u" ];then
    echo "你确定要增量安装吗？请考虑清楚后做操作！输入：yes 继续，否则安装终止"
    read answer
    if [ "$answer" == "yes" ];then
        echo "请再次确认是否选择增量安装！输入：yes 继续，否则安装终止"
        read answer
        if [ "$answer" != "yes" ];then
            echo "install terminated..."
            exit 0
        else
            update_install
        fi
    else
        echo "install terminated..."
        exit 0
    fi
fi

# 如果传入的参数为启动服务，则调用启动服务脚本
if [ "$ISSTART" == "-s" ]; then
    # 启动服务
    echo "`date` start to startup rvmanageServer--------------" >> ${INSTALL_LOG} 2>&1;
    echo -e "\033[32;49;1m [-----------start to startup rvmanageServer-------] \033[39;49;0m"

    start_rvmanageServer >> ${INSTALL_LOG} 2>&1
    # 检查服务是否启动
    status_rvmanageServer
fi

