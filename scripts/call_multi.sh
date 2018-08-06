#!/bin/bash -e

function info() {
echo Usage: `basename $0` 'GVCF.LIST'
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

# path=$1
# find $path -name '*.g.vcf' > $out_prefix.gvcf.list
gvcf_combine.sh -p$out_prefix -i$interval $1
gvcf_gt.sh -p$out_prefix -i$interval $out_prefix.combine.g.vcf

. $cmd_done
