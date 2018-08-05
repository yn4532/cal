#!/bin/bash -e

function info() {
echo Usage: `basename $0` 'bam'
exit 1
}

while getopts  ":p:f:i:" opt; do
	case  $opt  in
		p) out_prefix=$OPTARG;;
		f) suffix=$OPTARG;;
        i) interval=$OPTARG;;
		*) info;;
	esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi

. $var

test -n "$interval" && interval='-L $interval'

# HaplotypeCaller # its use is not recommended for somatic (cancer) variant discovery. For that purpose, use MuTect2 instead.

echo; echo HaplotypeCaller
java.sh -m$java_memory -d$java_tmp_dir $gatk \
    HaplotypeCaller \
    -R $ref_genome \
    -I $1 \
    --emitRefConfidence GVCF \
    $interval \
    -o $out_prefix.g.vcf


. $cmd_done

