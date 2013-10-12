#!/bin/bash

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}

delete=""
#if [ ! -e publish/ctg-albany-edu-standard_setter-latest.nt ]; then
#  delete="publish/ctg-albany-edu-standard_setter-latest.nt"
#  if [ -e publish/ctg-albany-edu-standard_setter-latest.nt.gz ]; then
#    gunzip -c publish/ctg-albany-edu-standard_setter-latest.nt.gz > publish/ctg-albany-edu-standard_setter-latest.nt
#  elif [ -e publish/ctg-albany-edu-standard_setter-latest.ttl ]; then
#    echo "cHuNking publish/ctg-albany-edu-standard_setter-latest.ttl into publish/ctg-albany-edu-standard_setter-latest.nt; will delete when done lod-mat'ing"
#    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/ctg-albany-edu-standard_setter-latest.ttl > publish/ctg-albany-edu-standard_setter-latest.nt
#  elif [ -e publish/ctg-albany-edu-standard_setter-latest.ttl.gz ]; then
#    gunzip -c publish/ctg-albany-edu-standard_setter-latest.ttl.gz > publish/ctg-albany-edu-standard_setter-latest.ttl
#    echo "cHuNking publish/ctg-albany-edu-standard_setter-latest.ttl into publish/ctg-albany-edu-standard_setter-latest.nt; will delete when done lod-mat'ing"
#    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/ctg-albany-edu-standard_setter-latest.ttl > publish/ctg-albany-edu-standard_setter-latest.nt
#    rm publish/ctg-albany-edu-standard_setter-latest.ttl
#  else
#    echo publish/ctg-albany-edu-standard_setter-latest.nt, publish/ctg-albany-edu-standard_setter-latest.nt.gz, publish/ctg-albany-edu-standard_setter-latest.ttl, or publish/ctg-albany-edu-standard_setter-latest.ttl.gz needed to lod-materialize.
#    delete=""
#    exit 1
#  fi
#fi
load_file=""
if [ -e     "publish/ctg-albany-edu-standard_setter-latest.nt" ]; then
  load_file="publish/ctg-albany-edu-standard_setter-latest.nt"
elif [ -e   "publish/ctg-albany-edu-standard_setter-latest.ttl" ]; then
  load_file="publish/ctg-albany-edu-standard_setter-latest.ttl"
elif [ -e   "publish/ctg-albany-edu-standard_setter-latest.ttl.gz" ]; then
  load_file="publish/ctg-albany-edu-standard_setter-latest.ttl"
  gunzip -c  publish/ctg-albany-edu-standard_setter-latest.ttl.gz > publish/ctg-albany-edu-standard_setter-latest.ttl
     delete="publish/ctg-albany-edu-standard_setter-latest.ttl"
elif [ -e   "publish/ctg-albany-edu-standard_setter-latest.nt.gz" ]; then
  load_file="publish/ctg-albany-edu-standard_setter-latest.nt"
  gunzip -c  publish/ctg-albany-edu-standard_setter-latest.nt.gz > publish/ctg-albany-edu-standard_setter-latest.nt
     delete="publish/ctg-albany-edu-standard_setter-latest.nt"
fi

mkdir publish/tdb                         &> /dev/null
rm    publish/tdb/*.dat publish/tdb/*.idn &> /dev/null

if [[ ${#load_file} -eq 0 ]]; then
   echo "[ERROR] `basename $0 `could not find dump file to load."
   exit 1
fi
echo `basename $load_file` into publish/tdb as http://ichoose.tw.rpi.edu/source/ctg-albany-edu/dataset/standard_setter/version/latest >> publish/ng.info

#if [[ ! `which tdbloader` ]]; then
#   echo "ERROR: tdbloader not found."
#   exit
#fi
if [[ $load_file == "publish/ctg-albany-edu-standard_setter-latest.ttl" && "`too-big-for-rapper.sh`" == "yes" ]]; then
  dir="publish"
  echo "cHuNking publish/ctg-albany-edu-standard_setter-latest.ttl in $dir"
  rm $dir/cHuNk*.ttl &> /dev/null
  ${CSV2RDF4LOD_HOME}/bin/split_ttl.pl $load_file
  for cHuNk in $dir/cHuNk*.ttl; do
    echo giving $cHuNk to tdbloader
    tdbloader --loc=publish/tdb --graph=`cat publish/ctg-albany-edu-standard_setter-latest.nt.graph` $cHuNk
    rm $cHuNk
  done
else
  tdbloader --loc=publish/tdb --graph=`cat publish/ctg-albany-edu-standard_setter-latest.nt.graph` $load_file
fi

if [ ${#delete} -gt 0 ]; then
   rm $delete
fi
