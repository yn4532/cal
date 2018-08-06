#!/bin/bash -e

function info() {
    echo Usage: `basename $0` [vsc] virtual_name list
    exit 1
}

while getopts ":pvsc:" opt
do
    case $opt in
        p) out_prefix=$OPTARG;;
        v) virtual=new;;
        s) package=new;;
        c) config=$OPTARG;;
        *) info;;
    esac
done
shift $(($OPTIND - 1))


if [ $# -lt 1 ]; then info; fi

package_name=git+https://@gitee.com/yingnn/cal.git

if test -n "$virtual"; then
    virtual="pip install virtualenv && virtualenv $1"
    package="pip install $package_name"
fi

test -n "$package" && package="pip install -U $package_name"
test -n "$config" && config="--config $config"

eval $vritual
unset PYTHONPATH
. $1/bin/activate
eval $package
yful $config -p$out_prefix $2

