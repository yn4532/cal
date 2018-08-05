#!/bin/bash -e

function info() {
echo Usage: `basename $0` [-d1] in.bam
exit 1
}

while getopts ":dp:1" opt
do
    case $opt in
        d) delete=true;;
		p) out_prefix=$OPTARG;;
        1) picard='picard.jar';;
		?) info;;
    esac
done
shift $(($OPTIND - 1))

if [ $# -lt 1 ]; then info; fi

. $var

test "$delete" = "true" && delete='REMOVE_DUPLICATES=true'

if test -z "$picard"; then
    markdup=$picard_path/MarkDuplicates.jar
else
    markdup="$picard MarkDuplicates"
fi

echo;echo;echo $markdup
$java_run \
$markdup \
I=$1 \
O=$out_prefix.deldup.bam \
METRICS_FILE=$out_prefix.deldup.metrics.txt \
PROGRAM_RECORD_ID=dup \
PROGRAM_GROUP_NAME=dup \
CREATE_INDEX=true $delete


# cat $out_prefix.*dup.metrics.txt|grep -v '^#'|tab2xls.pl - $out_prefix.dup.xls

. $cmd_done
