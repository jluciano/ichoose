#3> <#> a <http://purl.org/twc/vocab/conversion/CSV2RDF4LOD_environment_variables> ;
#3>     rdfs:seeAlso 
#3>     <http://purl.org/twc/page/csv2rdf4lod/distributed_env_vars>,
#3>     <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Script:-source-me.sh> .

export CSV2RDF4LOD_CONVERT_PERSON_URI="http://tw.rpi.edu/web/user/450"
source /home/djokosayogo/prizms/ichoose/data/source/csv2rdf4lod-source-me-for-ichoose.sh
alias ichoose='sudo su ichoose'
export PATH=$PATH`/home/djokosayogo/opt/prizms/bin/install/paths.sh`
export CLASSPATH=$CLASSPATH`/home/djokosayogo/opt/prizms/bin/install/classpaths.sh`
export CSV2RDF4LOD_HOME="/home/djokosayogo/opt/prizms/repos/csv2rdf4lod-automation"
export DATAFAQS_HOME="/home/djokosayogo/opt/prizms/repos/DataFAQs"
export JENAROOT=
