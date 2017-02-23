#! /bin/bash

set -ex

echo "1: $1"
SRC_DIR=${1:-$(pwd)}
echo "SRC_DIR is $SRC_DIR; pwd is $(pwd)"
ls -l

mkdir -p $SRC_DIR
cd $SRC_DIR

git clone --depth=1 --single-branch --branch=${OE_CORE:-master} https://github.com/openembedded/openembedded-core.git
(cd openembedded-core && git clone --depth=1 --single-branch --branch=${BITBAKE:-master} https://github.com/openembedded/bitbake.git)
git clone --depth=1 --single-branch --branch=master git://git.openembedded.org/meta-openembedded

. openembedded-core/oe-init-build-env $SRC_DIR/build

bitbake-layers add-layer $SRC_DIR/meta-ros
bitbake-layers add-layer $SRC_DIR/meta-openembedded/meta-oe
bitbake-layers add-layer $SRC_DIR/meta-openembedded/meta-python
bitbake-layers add-layer $SRC_DIR/meta-openembedded/meta-multimedia

cat >>conf/local.conf <<EOF
DISTRO_FEATURES_append = " opengl"
LICENSE_FLAGS_WHITELIST = "commercial"
EOF

ls -l

pwd
cat conf/local.conf
cat conf/bblayers.conf

df -h .
$SRC_DIR/meta-ros/scripts/travis-cmd-wrapper.py bitbake packagegroup-ros-world
df -h .
