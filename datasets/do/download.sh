#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1


# DO Disease Ontology
wget -N -a download.log https://github.com/DiseaseOntology/HumanDiseaseOntology/raw/master/src/ontology/HumanDO.owl
