#!/bin/bash -e

function info() {
echo Usage: `basename $0` 'sort.bam'
exit 1
}

while getopts  ":p:f:" opt; do
	case  $opt  in
		p) out_prefix=$OPTARG;;
		f) suffix=$OPTARG;;
		*) info;;
	esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi

. $var

echo samtools index
samtools index $1

. $cmd_done
