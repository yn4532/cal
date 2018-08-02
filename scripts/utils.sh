#!/bin/bash


function ch_std() {
    exec 6>&1
    exec 1>>$1
    exec 2>&1
}


# function recovery_std() {
#     exec 1>&6
#     exec 2>&1
#     exec 6>&-
# }


function set_env() {
    echo
}


function get_date() {
    echo `date '+%Y-%m-%d %H:%M:%S'`
}


function get_abs() {
    python -c "import os; print(os.path.abspath('$1'))"
}


function opt() {
    if test -n "$2"; then
        echo $1 $2
    fi
}


function default() {
    if test -z "$1"; then
        eval $1=$2
    fi
}


function get_info() {
echo `id -u` `get_date` `hostname`:$PWD $$ $1
}


function get_same_length() {
    len=`echo $1|wc -c|sed 's/^  *//'`
    ((len=len-1))
    for i in `seq $len`; do
        printf '='
    done
}


function set_log_start() {
    info="`get_info "$1"` start"
    info1=`get_same_length "$info"`
    echo $info1
    echo $info
    echo
}


function set_log_done() {
    wait

    info="`get_info "$1"` done"
    info1=`get_same_length "$info"`
    echo
    echo $info
    echo $info1
    # echo; echo
}


function set_plog_start() {
    info="`get_info "$1"` start"
    echo $info >> .plog
}


function set_plog_done() {
    info="`get_info "$1"` done"
    echo $info >> .plog
    exit 0
}


function set_done() {
    set_log_done "$cmd_args"
    set_plog_done "$cmd_args"
}


function default_() {
    out_prefix=${out_prefix:=1}
    sample_name=${sample_name:=sample_test}
    test -z "$interval" && interval=$interval_init
    echo interval $interval
    echo out_prefix $out_prefix
    echo sample_name $sample_name
    echo
}


function trans_cap() {
echo $1|tr A-Z a-z
}

ch_std .log

pid=$$

cmd_args="`basename $0` $@"
# cmd_end="END $cmd_args"
cmd_done=`which log_done.sh`


# exec 6>&1
# exec 1>>$log
# exec 2>&1




set_plog_start "$cmd_args"
set_log_start "$cmd_args"

# echo $cmd_done
default_
sample_name=`trans_cap "$sample_name"`
