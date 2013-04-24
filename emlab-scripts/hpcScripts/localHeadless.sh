#!/bin/bash

########################################################################
# The jobname must only consist of the characters A-Z, a-z and 0-9!!!! #
########################################################################
USAGE="Provide name of run and number of runs"
#Load configuration script to substitute
if [ -f ~/emlab/emlab-scripts/hpcScripts/scriptConfigurations.cfg ]; then 
	. ~/emlab/emlab-scripts/hpcScripts/scriptConfigurations.cfg
	HOME=$REMOTERESULTFOLDER
else
    echo "Define scriptConfigurations.cfg, by changing the template. Exiting script."
    exit
fi

## the first parameter gives the jobname, the second the scenario-file including the xml file-ending
## Example sh localHeadless.sh example 2 scenarioA-ToyModel.xml
JOBNAME=ThermalMix
#NROFRUNS=$2
SCENARIO=scenarioB-ThermalMixDE.xml
SCENARIOPATH=file://$LOCALSCENARIOFOLDER
#SCENARIO=scenarioB-ThermalMixDE.xml

mkdir $LOCALRESULTFOLDER/ThermalMix

for PBS_ARRAYID in {1..1}
do
java -d64 -server -Xmx3072m -Drun.id=$JOBNAME-$PBS_ARRAYID -DSCENARIO_FOLDER=$SCENARIOPATH -Dresults.path=$LOCALRESULTFOLDER/$JOBNAME -Dscenario.file=$SCENARIO -jar $JARFILE
done
