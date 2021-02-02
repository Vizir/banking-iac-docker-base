#!/usr/bin/env sh

env_dir=$1
shift

for d in $env_dir; do
  if [[ -d "$d" ]]; then
    printf "\n==> $d: terragrunt $@\n\n"
    (cd $d && terragrunt $@)
  fi
done
