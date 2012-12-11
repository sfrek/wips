#!/bin/bash

[[ $# < 1 ]] && echo "Falta el nombre para el WIP" && exit 1

NAME="WIP.$(date +%Y%m%d).$@.markdown"
NAME=${NAME//\ /-}
touch ${NAME}
git add ${NAME}
git commit -m 'Add New WIP'
echo -e "\033[01;31mFalta realizar el push\033[00m"
