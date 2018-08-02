"""
yful utils

"""
# coding: utf-8
from __future__ import print_function, division
import os
import sys
import re
import configparser


if os.name == 'posix' and sys.version_info[0] < 3:
    try:
        import subprocess32 as subprocess
    except ImportError as e:
        import subprocess


def get_abs(path):
    p = os.path.expanduser(path)
    p = os.path.expandvars(p)
    return os.path.abspath(p)


def get_rel(path):
    return os.path.split(path)[-1]


def get_dir(path):
    return os.path.split(path)[0]


def proc(args):
    p = subprocess.Popen(args, bufsize=0, executable=None,
                         stdin=None,
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE,
                         preexec_fn=None, close_fds=False,
                         shell=False, cwd=None, env=None,
                         universal_newlines=False, startupinfo=None,
                         creationflags=0)
    return p.communicate()


def get_config(ini_file):
    config = configparser.ConfigParser()
    config.read(ini_file)
    return config
