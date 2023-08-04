#!/bin/bash

R -e "library(devtools)\ninstall()\nlibrary(httr2)\nlibrary(clinicalomicsdbR)\nclinicalomicsdbR\$filter()"
