#!/bin/bash
#
# run from source/ctg-albany-edu/standard_setter/version/latest
#
# CSV2RDF4LOD_PUBLISH_LOD_MATERIALIZATION_WWW_ROOT
# was 
# 
# when this script was created. 

wwwroot=$CSV2RDF4LOD_PUBLISH_VARWWW_ROOT
if [ -z "$wwwroot" ]; then
  wwwroot=$CSV2RDF4LOD_PUBLISH_LOD_MATERIALIZATION_WWW_ROOT
fi
if [ -z "$wwwroot" ]; then
  echo "wwwroot not defined."
  exit 1
fi

verbose="no"
if [[ "$1" == "-v" ]]; then
  verbose="yes"
  shift
fi

symbolic=""
pwd=""
if [[ "$1" == "-s" || "$CSV2RDF4LOD_PUBLISH_VARWWW_LINK_TYPE" == "soft" ]]; then
  symbolic="-sf "
  pwd=`pwd`/
  shift
fi

sudo="sudo"
if [ `whoami` == root ]; then
   sudo=""
elif [[ "`stat --format=%U "$wwwroot/source"`" == `whoami` ]]; then
   sudo=""
fi

file="file"

##################################################
# Link all original files from the /file/ directory structure to the web directory.
# (these are from source/)
##################################################
# Link all INPUT CSV files from the /file/ directory structure to the web directory.
# (this could be from manual/ or source/
if [ -e "manual/standard_setter.csv" ]; then 
   wwwfile="$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/manual/standard_setter.csv"
   if [ -e "$wwwfile" ]; then 
      $sudo rm -f "$wwwfile"
   else
      $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/standard_setter.csv" "$wwwfile"
else
   echo "  -- manual/standard_setter.csv omitted --"
fi

##################################################
# Link all raw and enhancement PARAMETERS from the file directory structure to the web directory.
#
if [ -e "automatic/standard_setter.csv.raw.params.ttl" ]; then 
   wwwfile="$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/automatic/standard_setter.csv.raw.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}automatic/standard_setter.csv.raw.params.ttl" "$wwwfile"
else
   echo "  -- automatic/standard_setter.csv.raw.params.ttl omitted --"
fi

if [ -e "manual/standard_setter.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/manual/standard_setter.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/standard_setter.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/standard_setter.csv.e1.params.ttl omitted --"
fi

##################################################
# Link all PROVENANCE files that describe how the input CSV files were obtained.
#
##################################################
# Link all bundled RDF output files from the source/.../file directory structure to the web directory.
#
dump=ctg-albany-edu-standard_setter-latest.ttl
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then 
   if [ -e $wwwfile.gz ]; then
    $sudo rm -f $wwwfile.gz
   else
     $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- full ttl omitted -- "
fi

dump=ctg-albany-edu-standard_setter-latest.nt
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then 
   if [ -e $wwwfile.gz ]; then
    $sudo rm -f $wwwfile.gz
   else
     $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- full nt omitted -- "
fi

dump=ctg-albany-edu-standard_setter-latest.rdf
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then 
   if [ -e $wwwfile.gz ]; then
    $sudo rm -f $wwwfile.gz
   else
     $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- full rdf omitted -- "
fi

dump=ctg-albany-edu-standard_setter-latest.raw.ttl
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw ttl omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.raw.sample.ttl
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw sample ttl omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.raw.nt
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw nt omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.raw.sample.nt
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw sample nt omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.raw.rdf
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw rdf omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.raw.sample.rdf
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw sample rdf omitted --"
fi


dump=ctg-albany-edu-standard_setter-latest.e1.ttl
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 ttl omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.e1.sample.ttl
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 sample ttl omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.e1.nt
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 nt omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.e1.sample.nt
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 sample nt omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.e1.rdf
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 rdf omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.e1.sample.rdf
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 sample rdf omitted --"
fi


dump=ctg-albany-edu-standard_setter-latest.sameas.ttl
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas ttl omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.sameas.sample.ttl
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas sample ttl omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.sameas.nt
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas nt omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.sameas.sample.nt
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas sample nt omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.sameas.rdf
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas rdf omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.sameas.sample.rdf
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas sample rdf omitted --"
fi


dump=ctg-albany-edu-standard_setter-latest.void.ttl
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void ttl omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.void.sample.ttl
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void sample ttl omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.void.nt
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void nt omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.void.sample.nt
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void sample nt omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.void.rdf
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void rdf omitted --"
fi

dump=ctg-albany-edu-standard_setter-latest.void.sample.rdf
wwwfile=$wwwroot/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void sample rdf omitted --"
fi


