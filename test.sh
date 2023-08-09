#!/bin/bash

R -e "library(devtools)\ninstall()\nlibrary(httr2)\nlibrary(clinicalomicsdbR)\nclinicalomicsdbR\$new()\$download('Gide_Cell_2019_nivo.csv')"
