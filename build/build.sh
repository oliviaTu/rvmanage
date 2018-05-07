#!/bin/sh

PROPERTIES="build.properties"
PRODUCT_NAME="CDN_RVManage_SERVER"
DEPENDENCY="dependencies"

RED_COLOE='\E[31m'
GREEN_COLOR='\E[32m'
YELLOW_COLOR='\E[33m'
BLUE_COLOR='\E[34m'

REDB_COLOE='\E[1;31m'
GREENB_COLOR='\E[1;32m'
YELLOWB_COLOR='\E[1;33m'
BLUEB_COLOR='\E[1;34m'

RES='\E[0m'

log_info() {
    echo -e "${GREEN_COLOR}$1${RES}"
}

log_info_wait() {
    echo -en "${GREEN_COLOR}$1${RES}"
}

log_error() {
    echo -e "${REDB_COLOE}$1${RES}"
}

log_success() {
    echo -e "${GREENB_COLOR}$1${RES}"
}

clean_up() {
    rm -rf ${BUILD}
    exit 1
}

die() {
    log_error "$1"
    clean_up
}

trap clean_up SIGINT SIGTERM

#if [ "$1" != "-t" ] && [ "$1" == "" ]; then
#    who=$(whoami)
#    if [[ ${who} != "root" ]]; then
#        die "Need root privilege"
#    fi
#fi

if [ ! -f ${PROPERTIES} ]; then
    die "${PROPERTIES} is not exists."
fi

NEName="RVMANAGE"
Version=$(grep 'ProductVersion=' ${PROPERTIES} | cut -d'=' -f2)
Module=$(grep 'Module=' ${PROPERTIES} | cut -d'=' -f2)
Provider="Sowell 视维"
BuildTime=$(date +"%Y-%m-%d %H:%M:%S")
BuildVersion=$(date +"%Y%m%d")
PATH=/opt/rh/python27/root/usr/bin:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

OUTPUT="output"
#ifconfig eth0 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'
#获取本机ip地址

OUTPUTPATH="${PWD}/output/"
rm -rf ${OUTPUTPATH}
mkdir -p ${OUTPUTPATH}

cd ../src
PYINSTALLERBUILD=pyinstaller_build
PYINSTALLERDIST=pyinstaller_dist
SOURCEFILE=rvmanage.py
PYINSTALLSOFTWARE=${PYINSTALLERDIST}/software
PYINSTALLERNAME=${SOURCEFILE%.*}

mkdir -p ${PYINSTALLSOFTWARE}
log_info_wait "Start to Pyinstaller ..."
pyinstaller --distpath ${PYINSTALLERDIST} --workpath ${PYINSTALLERBUILD}  ${SOURCEFILE}

#echo ${./pyinstaller --distpath ${PYINSTALLERDIST} --workpath ${PYINSTALLERBUILD}  ${SOURCEFILE}}


mv ${PYINSTALLERDIST}/${PYINSTALLERNAME} ${PYINSTALLSOFTWARE}/
mkdir -p ${PYINSTALLSOFTWARE}/${PYINSTALLERNAME}/utils
cp -rf utils/*  ${PYINSTALLSOFTWARE}/${PYINSTALLERNAME}/utils
#rm -rf ${PYINSTALLSOFTWARE}/${PYINSTALLERNAME}/utils/*.py
#rm -rf ${PYINSTALLSOFTWARE}/${PYINSTALLERNAME}/utils/casclient

if [ $? -ne 0 ]; then
    die " [FAIL]"
fi

cd ${PYINSTALLERDIST}

cp -r ../../scripts ./
if [ $? -ne 0 ]; then
    die " [FAIL]"
fi

echo $PWD
#cd ..
chmod 755 ../../scripts/*.sh
if [ $? -ne 0 ]; then
    die " [FAIL]"
fi
echo $PWD

cp ../../scripts/setup.sh ./
if [ $? -ne 0 ]; then
    die " [FAIL]"
fi

cat << EOF > param.properties
[DB]
;postgresql数据库用户名
db_username = postgres
;数据库密码s
db_password =
;数据库名
db_database = rvdbtest
;数据库链接类型(一般默认不变)
d_type = postgresql
;数据库连接池(可根据实际情况做调整)
db_pool_size = 30
;数据库所在服务器IP
db_host = 192.168.100.136
;数据库端口
db_port = 5432

[logdbinfo]
#记录操作日志的远程数据库IP
dbip = 192.168.100.136
#数据库用户名
usrid = postgres
#数据库登录密码
passwd =
#数据库端口
dbport = 5432
#数据库名
logdbname = rvdbtest


[LOGCONFPATH]
;rvmanage日志的配置文件路径
log_conf_path = /opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/utils/logsuite/LogSuite.conf
log_db_path = /opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/utils/logsuite/logdb.conf

[CAS]
#cas服务器后台
cas_operator_search  = 192.168.10.146:8822
key = ertjmFRGyriRFogjCDf38978
#cas 的redis地址
cas_host = 192.168.10.231
cas_port = 6379
cas_password = 123567


[CASD]
;cas日志的配置文件路径
cas_log_path = /opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/utils/casclient/LogSuite.conf
;cas配置文件路径
cas_conf_path = /opt/wisecloud/cdn/rvmanage/rvmanage_server/software/rvmanage/utils/casclient/casclient.ini
;libcas.so动态库文件路径
cas_lib_path = /usr/lib/libcas.so

[GETEPG]
;解析电子节目单的线程池的线程数和发送http请求的停歇时间
num = 10
sleep_time = 20

[HEARTBEAT]
# 检测RVLSS拉流间隔时间
stream_interval = 30
nginx_port = 9527
# 主动查询未录制节目的数据的间隔时间
record_rvlss = 30
# 定时通知未上传的节目的间隔时间
notify_vod = 100
# 重新通知点播重新下载失败文件的间隔时间
download_vod = 60

[CALLBACK]
#本机的端口
local_port = 9696
local_host = 192.168.100.134
file_diff_num = 10485760
interval_timer = 60


#authcenter
[SERVER]
#服务监听地址信息
auth_ip = 192.168.10.123
auth_port = 8888
#心跳接口URL
auth_url = /api/auth/heartbeat

EOF


touch version
echo "NEName=${NEName}" > version
echo "Version=${Version}" >> version
echo "Provider=${Provider}" >> version
echo "BuildTime=${BuildTime}" >> version

cd ../
PACKAGENAME=${PRODUCT_NAME}_${Version}_${BuildVersion}_${Module}

echo $PWD
mv ${PYINSTALLERDIST} ${PACKAGENAME}
log_info_wait "Start to pack ${NEName}..."
SVNVERSION=$(svnversion -c |sed 's/^.*://' |sed 's/[A-Z]*$//')

echo ${SVNVNERSION}
tar -zcvf ${OUTPUTPATH}/${PRODUCT_NAME}_${Version}_${BuildVersion}_${SVNVERSION}_${Module}.tar.gz ${PACKAGENAME} --exclude=.svn &> /dev/null
if [ $? -eq 0 ]; then
    log_success " [OK]"
else
    die " [FAIL]"
fi

rm -rf ${PACKAGENAME} ${PYINSTALLERBUILD} *.spec
exit 0
