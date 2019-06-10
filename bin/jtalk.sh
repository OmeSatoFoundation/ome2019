#!/bin/bash
set -eu
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

usage_exit() {
	echo "Usage: $0 [-m vocal] -w <speaking phrase> [-s filename]"
	echo "       echo <speaking phrase> | $0 -i [-m vocal]"
	exit 1
}

TMP=/tmp/jsay.wav
SPEAKING=
VOCAL=
I_FLAG=
W_FLAG=
S_FLAG=
SAVEFILE=

while getopts :m:w:s:i OPT
do
	case $OPT in
		i) I_FLAG=1
		   SPEAKING=$(cat -)
		        ;;
		w) W_FLAG=1
	  	   SPEAKING=$OPTARG
			;;
		m) VOCAL=$OPTARG
			;;
		s) S_FLAG=1
		   SAVEFILE=$OPTARG
			;;
		\?) usage_exit
			;;

	esac
done

if [ -z "$I_FLAG" ] && [ -z  "$W_FLAG" ]; then
	usage_exit
fi

if [ -z "$VOCAL" ]; then
	VOCAL=/usr/share/hts-voice/nitech-jp-atr503-m001/nitech_jp_atr503_m001.htsvoice
fi

if [ -z "$SPEAKING" ]; then
	SPEEAKING=$(cat -)
fi
	


echo "$SPEAKING" | open_jtalk \
-m $VOCAL \
-x /var/lib/mecab/dic/open-jtalk/naist-jdic \
-ow $TMP && \
aplay --quiet $TMP
if [ -n "$S_FLAG" ]; then
	cp $TMP $SAVEFILE
fi
rm -f $TMP
