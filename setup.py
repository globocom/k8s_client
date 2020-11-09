#!/usr/bin/env python
# -*- coding: utf-8 -*-

from k8s_client import __version__
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup


readme = open('README.rst').read()
history = open('HISTORY.rst').read().replace('.. :changelog:', '')

requirements = open('requirements.txt').read().split('\n')
requirements_txt = open('requirements_test.txt').read().split('\n')

test_requirements = requirements + requirements_txt

setup(
    name='dbaas-k8s-client',
    version=__version__,
    description='Client for k8s',
    long_description=readme + '\n\n' + history,
    author='dbaas',
    author_email='dbaas@g.globo',
    url='https://github.com/globocom/dbaas-k8s-client',
    packages=[
        'k8s_client',
    ],
    package_dir={'k8s_client':
                 'k8s_client'},
    include_package_data=True,
    install_requires=requirements,
    license="BSD",
    zip_safe=False,
    keywords='k8s_client,kubernetes,python',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: BSD License',
        'Natural Language :: English',
        "Programming Language :: Python :: 2",
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
    ],
    test_suite='tests',
)
