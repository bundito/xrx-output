#!/bin/bash

activeMode=""
activeOutput=""
modeline=0

echo "<xml>" >> xrx.xml
echo "<modelist>" >> xrx.xml
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
    echo "<modeline>" >> xrx.xml
    echo "<display>$activeOutput</display>" >> xrx.xml
    if [[ $freq =~ .*\*.* ]]
      then activeMode=$freq
      echo "<mode>"$mode"</mode>" >> xrx.xml
      echo "<current>true</current>" >> xrx.xml
      # echo $activeOutput $mode current
      else
      #echo $activeOutput $mode
      echo "<mode>"$mode"</mode>" >> xrx.xml
      echo "<current>false</current>" >> xrx.xml
    fi
    echo "</modeline>" >> xrx.xml
    let "modeline=modeline+1"
  fi

done
echo "</modelist>" >> xrx.xml
echo "</xml>" >> xrx.xml
