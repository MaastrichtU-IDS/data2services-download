#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

TARGET_DIR=$1

mkdir -p $TARGET_DIR
cd $TARGET_DIR

echo "Target directory: $TARGET_DIR"

wget -O ontologies.json -a download.log "http://data.bioontology.org/ontologies?apikey=$PASSWORD"

ddl_ontos=( $(cat ontologies.json | jq -r '.[].links.download') )

for onto_url in "${ddl_ontos[@]}"
do
  ONTO_DIRNAME=$(echo ${onto_url} | sed -r -n 's/.*ontologies\/(.*?)\/download.*/\1/p')
  echo "Ontology directory: $ONTO_DIRNAME"
  cd $TARGET_DIR
  mkdir -p $ONTO_DIRNAME
  cd $ONTO_DIRNAME
  echo "Downloading... $BASE_URI${onto_url}/?apikey=$PASSWORD"
  wget -O $ONTO_DIRNAME.rdf -a download.log "${onto_url}/?apikey=$PASSWORD"
done
