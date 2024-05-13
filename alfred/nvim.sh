#!/bin/bash

dir=$1

# --cmd ensures that LazyGit and Telescope have the correct cwd
neovide $dir -- --cmd "cd ${dir}"
