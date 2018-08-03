#!/bin/bash

function info() {
echo Usage: `basename $0` '<input.bam> <interval.bed>'
exit 1
}

while getopts  ":Gp:m:" opts
do
	case  $opts  in
	p) out_prefix=$OPTARG;;
	?) info;;
	esac
done
shift $(($OPTIND - 1))


if [ -z "$2" ]; then info;  fi


. $var


if [ -z $out_prefix ]; then
	out_prefix=1.gatk.depth
fi

echo;echo;echo gatk summary
java.sh -m$java_memory -d$java_tmp_dir $gatk \
   -T DepthOfCoverage \
   -R $ref_genome \
   -o $out_prefix \
   --omitDepthOutputAtEachBase \
   --omitLocusTable \
   --outputFormat csv \
   -I $1 \
   -L $2 \
   -ct 1 -ct 10 -ct 30 -ct 100

. $cmd_done
