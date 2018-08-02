#!/bin/bash -e

function info() {
echo Usage: `basename $0` '[-s sample_name] [-o out_dir] [-t threads] <fq|bam [...]>'
exit 1
}

while getopts  ":s:p:t:o:h" opts
do
        case  $opts  in
		s) sample_name=$OPTARG;;
		p) out_prefix=$OPTARG;;
		t) threads=$OPTARG;;
		o) out_dir=$OPTARG;;
		*) info;;
		esac
done
shift $(($OPTIND - 1))

if [ -z "$1" ]; then info; fi


. $var

threads={threads:=4}

base=`basename $1 .gz`
# prefix=`echo $base|rev|cut -f2 -d.|rev`
prefix=$base
echo fastqc prefix $prefix

fastqc -t $threads -o ${out_dir:=$PWD} $@


. $cmd_done



