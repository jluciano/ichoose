#!/bin/bash
#
# run automatic/lod-materialize-apache-ctg-albany-edu-certifier-latest.sh
# from ctg-albany-edu/certifier/version/latest/

                # The newer C version of lod-mat is faster.
c_lod_mat="c/"  # It is in the directory called 'c' within the lod-materialization project.
                # The C version silently passes some parameters that the native perl version used.
if [ ! -e $CSV2RDF4LOD_HOME/bin/lod-materialize/c/lod-materialize ]; then
   c_lod_mat="" # If it is not available, use the older perl version.
   echo "WARNING: REALLY SLOW lod-materialization going on. Run make in $CSV2RDF4LOD_HOME/bin/lod-materialize/c/"
fi

perl $CSV2RDF4LOD_HOME/bin/lod-materialize/${c_lod_mat}lod-materialize.pl -i=ntriples --uripattern="/source/([^/]+)/dataset/(.*)" --filepattern="/source/\\1/file/\\2" --apache publish/ctg-albany-edu-certifier-latest.nt http://ichoose.tw.rpi.edu publish/lod-mat
perl $CSV2RDF4LOD_HOME/bin/lod-materialize/${c_lod_mat}lod-materialize.pl -i=ntriples --uripattern="/source/([^/]+)/vocab/(.*)" --filepattern="/source/\\1/vocab_file/\\2" --apache publish/ctg-albany-edu-certifier-latest.nt http://ichoose.tw.rpi.edu publish/lod-mat
