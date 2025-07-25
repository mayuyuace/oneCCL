#!/bin/bash
#
# Copyright 2016-2020 Intel Corporation
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

REPO=https://github.com/openpmix/openpmix.git

install_path_root=`pwd`
install_path=`pwd`/_install

git clone $REPO
pushd ./openpmix
#version sould be clarified and aligned with Borealis maintainer
target_version="v5.0.7"
git checkout ${target_version}

git submodule update --init --recursive
./autogen.pl
./configure --prefix=$install_path

cp $install_path_root/openpmix/include/pmix.h $install_path_root/include
cp $install_path_root/openpmix/include/pmix_common.h $install_path_root/include
cp $install_path_root/openpmix/include/pmix_deprecated.h $install_path_root/include
cp $install_path_root/openpmix/include/pmix_version.h $install_path_root/include
popd

git add include
git commit -m "deps: updated pmix to ${target_version}"

rm -rf $install_path_root/openpmix
