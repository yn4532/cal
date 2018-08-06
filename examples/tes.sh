#!/bin/bash -e

function info() {
    echo Usage: `basename $0` [vs] virtual_name config list
    exit 1
}

while getopts ":pvs" opt
do
    case $opt in
        p) out_prefix=$OPTARG;;
        v) virtual=new;;
        *) info;;
    esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi

package_name=git@gitee.com:yingnn/cal.git

if test -n "$virtual"; then
    virtual="pip install virtualenv && virtualenv $1"
    package="pip install $package_name"
fi

test -n "$package" && package="pip install $package_name"

eval $vritual
unset PYTHONPATH
. $1/bin/activate
eval $package
yful --config $2 -p$out_prefix $3

