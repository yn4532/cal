#!/bin/bash -e

function info() {
echo Usage: `basename $0` [-d] in.bam
exit 1
}

while getopts  ":dp:" opts
do
        case  $opts  in
        d)
			delete=true
			;;
		p)
			out_prefix=$OPTARG
			;;
		\?) info;;
        esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi

. $var

test "$delete" = "true" && delete='REMOVE_DUPLICATES=true'

echo;echo;echo picard MarkDuplicates
java.sh -m12g $picard_path/MarkDuplicates.jar \
I=$1 \
O=$out_prefix.deldup.bam \
METRICS_FILE=$out_prefix.deldup.metrics.txt \
PROGRAM_RECORD_ID=dup \
PROGRAM_GROUP_NAME=dup \
CREATE_INDEX=true $delete


# cat $out_prefix.*dup.metrics.txt|grep -v '^#'|tab2xls.pl - $out_prefix.dup.xls

. $cmd_done
