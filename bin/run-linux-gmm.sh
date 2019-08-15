#! /bin/sh
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
julius -C ${SCRIPT_DIR}/julius_conf/main.jconf -C ${SCRIPT_DIR}/julius_conf/am-gmm.jconf -demo $*
