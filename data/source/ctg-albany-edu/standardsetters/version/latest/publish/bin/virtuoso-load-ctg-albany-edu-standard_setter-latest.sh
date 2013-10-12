#!/bin/bash
#
# run publish/bin/virtuoso-load-ctg-albany-edu-standard_setter-latest.sh
# from source/ctg-albany-edu/standard_setter/version/latest/
#
# graph was http://ichoose.tw.rpi.edu/source/ctg-albany-edu/dataset/standard_setter/version/latest during conversion
# metadataset graph was auto during conversion
#
#        $CSV2RDF4LOD_PUBLISH_METADATASET_GRAPH_NAME            # <---- Loads into this with param --as-metadatset
#
#
#                               AbstractDataset                  # <---- Loads into this with param --abstract
#                     (http://.org/source/sss/dataset/ddd)                                                         
#                                     |                   \                                                        
# Loads into this by default -> VersionedDataset           meta  # <---- Loads into this with param --meta
#              (http://.org/source/sss/dataset/ddd/version/vvv)                                                    
#                                     |                                                                            
#                                LayerDataset                                                                      
#                                   /    \                                                                         
# Never loads into this ----> [table]   DatasetSample            # <---- Loads into this with param --sample
#
# See https://github.com/timrdf/csv2rdf4lod-automation/wiki/Aggregating-subsets-of-converted-datasets
# See https://github.com/timrdf/csv2rdf4lod-automation/wiki/Named-graph-organization

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}
CSV2RDF4LOD_BASE_URI=${CSV2RDF4LOD_BASE_URI:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}

if [ `is-pwd-a.sh cr:dev` == 'yes' ]; then
   echo "Refusing to publish; see 'cr:dev and refusing to publish' at"
   echo "  https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-environment-variables-%28considerations-for-a-distributed-workflow%29"
   exit 1
fi
if [ -e 'publish/bin/ln-to-www-root-ctg-albany-edu-standard_setter-latest.sh' ]; then
   # Make sure that the file we will load from the web is published
   publish/bin/ln-to-www-root-ctg-albany-edu-standard_setter-latest.sh
fi

base="${CSV2RDF4LOD_BASE_URI_OVERRIDE:-$CSV2RDF4LOD_BASE_URI}"
graph="$base/source/ctg-albany-edu/dataset/standard_setter/version/latest"
metaGraph="$graph"
if [ "$1" == "--sample" ]; then
   layerSlug="raw"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/ctg-albany-edu-standard_setter-latest.raw.sample.ttl"
   echo pvload.sh $sampleURL -ng $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $sampleURL -ng $sampleGraph

   layerSlug="enhancement/1"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/ctg-albany-edu-standard_setter-latest.e1.sample.ttl"
   echo pvload.sh $sampleURL -ng $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $sampleURL -ng $sampleGraph

   exit 1
elif [[ "$1" == "--meta" && -e 'publish/ctg-albany-edu-standard_setter-latest.void.ttl' ]]; then
   metaURL="$base/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/ctg-albany-edu-standard_setter-latest.void.ttl"
   metaGraph="$base"/vocab/Dataset
   echo pvload.sh $metaURL -ng $metaGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $metaURL -ng $metaGraph
   exit 1
fi

# Change the target graph before continuing to load everything
if [[ "$1" == "--unversioned" || "$1" == "--abstract" ]]; then
   # strip off version
   graph="`echo $graph\ | perl -pe 's|/version/[^/]*$||'`"
   graph="$base/source/ctg-albany-edu/dataset/standard_setter"
   echo populating abstract named graph \($graph\) instead of versioned named graph.
elif [[ "$1" == "--meta" ]]; then
   metaGraph="$base/vocab/Dataset"
elif [[ "$1" == "--as-metadataset" ]]; then
   graph="${CSV2RDF4LOD_PUBLISH_METADATASET_GRAPH_NAME:-'http://purl.org/twc/vocab/conversion/MetaDataset'}"
   metaGraph="$graph"
elif [ $# -gt 0 ]; then
   echo param not recognized: $1
   echo usage: `basename $0` with no parameters loads versioned dataset
   echo usage: `basename $0` --{sample, meta, abstract}
   exit 1
fi

# Load the metadata, either in the same named graph as the data or into a more global one.
metaURL="$base/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/ctg-albany-edu-standard_setter-latest.void.ttl"
echo pvload.sh $metaURL -ng $metaGraph
${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $metaURL -ng $metaGraph
if [[ "$1" == "--meta" ]]; then
   exit 1
fi



dump='publish/ctg-albany-edu-standard_setter-latest.nt'
url='http://ichoose.tw.rpi.edu/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/ctg-albany-edu-standard_setter-latest.nt'
if [ -e $dump ]; then
   echo pvload.sh $url -ng $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $url -ng $graph
   exit 1
elif [ -e $dump.gz ]; then
   echo pvload.sh $url.gz -ng $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $url.gz -ng $graph
   exit 1
fi

dump='publish/ctg-albany-edu-standard_setter-latest.ttl'
url='http://ichoose.tw.rpi.edu/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/ctg-albany-edu-standard_setter-latest.ttl'
if [ -e $dump ]; then
   echo pvload.sh $url -ng $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $url -ng $graph
   exit 1
elif [ -e $dump.gz ]; then
   echo pvload.sh $url.gz -ng $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $url.gz -ng $graph
   exit 1
fi

dump='publish/ctg-albany-edu-standard_setter-latest.rdf'
url='http://ichoose.tw.rpi.edu/source/ctg-albany-edu/file/standard_setter/version/latest/conversion/ctg-albany-edu-standard_setter-latest.rdf'
if [ -e $dump ]; then
   ${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $url -ng $graph
   exit 1
elif [ -e $dump.gz ]; then
   ${CSV2RDF4LOD_HOME}/bin/util/pvload.sh $url.gz -ng $graph
   exit 1
fi
#3> <> prov:wasAttributedTo <http://ichoose.tw.rpi.edu/id/csv2rdf4lod/7cdcb205896ae942db82900b0a38ef26> .
#3> <> prov:generatedAtTime "2013-08-03T23:59:59+00:00"^^xsd:dateTime .
#3> <http://ichoose.tw.rpi.edu/id/csv2rdf4lod/7cdcb205896ae942db82900b0a38ef26> foaf:name "convert-standard_setter.sh" .
