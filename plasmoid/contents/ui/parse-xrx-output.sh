#!/bin/bash

activeMode=""
activeOutput=""

xrandr | while IFS= read -r line; do
  set -r
  set $line
#  echo "$1 $2"

  if [[ $1 == "Screen" ]]
  then
    continue
  fi

  if [[ $2 =~ 'connected' ]] && [[ $3 == "primary" ]]
    then activeOutput=$1
    continue
  fi

  if [[ $2 =~ 'connected' ]] && [[ $3 != "primary" ]]
  then
    activeOutput=""
    continue
  fi

  mode=$1
  freq=$2
  prim=$3

  if [[ $activeOutput != "" ]]
  then

    if [[ $freq =~ .*\*.* ]]
      then activeMode=$freq
      echo $activeOutput $mode current
      else
      echo $activeOutput $mode
    fi

  fi

done
