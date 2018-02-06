#!/bin/bash

activeMode=""
activeOutput=""
modeline=0

echo "<xml>"
echo "<modelist>"
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
    #echo "<output='$activeOutput'>"
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
    echo "<modeline>"
    echo "<display>$activeOutput</display>"
    if [[ $freq =~ .*\*.* ]]
      then activeMode=$freq
      echo "<mode>"$mode"</mode>"
      echo "<current>true</current>"
      # echo $activeOutput $mode current
      else
      #echo $activeOutput $mode
      echo "<mode>"$mode"</mode>"
      echo "<current>false</current>"
    fi
    echo "</modeline>"
    let "modeline=modeline+1"
  fi

done
echo "</modelist>"
echo "</xml>"
