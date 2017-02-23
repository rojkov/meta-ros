#! /bin/bash

set -ex

SRC_DIR=${1-$(pwd)}
echo "SRC_DIR is $SRC_DIR; pwd is $(pwd)"
ls -l

mkdir -p $SRC_DIR
cd $SRC_DIR

git clone --depth=1 --single-branch --branch=${OE_CORE:-master} https://github.com/openembedded/openembedded-core.git
(cd openembedded-core && git clone --depth=1 --single-branch --branch=${BITBAKE:-master} https://github.com/openembedded/bitbake.git)
git clone --depth=1 --single-branch --branch=master git://git.openembedded.org/meta-openembedded

. openembedded-core/oe-init-build-env $SRC_DIR/build

ls -l

pwd
cat conf/local.conf
cat conf/bblayers.conf


