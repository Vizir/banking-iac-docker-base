#!/usr/bin/dumb-init /bin/bash

env_dir=$1

if [[ -d "$env_dir" ]]; then
  shift
  cd $env_dir
fi

terragrunt $@
