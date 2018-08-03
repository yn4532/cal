#!/usr/bin/env python
"""yful

"""
from __future__ import division, print_function
import os
import glob
from setuptools import setup, find_packages


VERSION = '0.0.0'


scripts = ['scripts/yful']
scripts.extend(glob.glob('scripts/*.sh'))
scripts.extend(glob.glob('scripts/*.py'))
print(scripts)


def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()


setup(
    name="yful",
    packages=find_packages(),
    version=VERSION,
    description="yful",
    maintainer='yingnn',
    author='yingnn',
    long_description=read('README.md'),
    keywords=['yful'],
    licence='MIT license',
    include_package_data=True,
    platforms=["Linux", "Mac OS-X", "Unix"],
    install_requires=['argparse',
                      'configparser'],
    scripts=scripts,
)
