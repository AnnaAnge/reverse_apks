#!/bin/bash

if [ -z "$1" ]
then echo "The syntax is ./apk_reverse.sh path_till_the_apk" && ps -ef | grep apk_reverse.sh | grep -v grep | awk '{print $2}' | xargs kill
else
mkdir -v output
cd output
echo "--------------------------------------------------------------------------------------------------------------"
echo "Hello, i am initiating the reverse engineering session"
echo "Be aware that depending on the distro you might have to insert this script to a specific file (i.e. dex2jar path)"
echo "=================================================================================================================="

echo "=================================================================================================================="
#apktool start
echo "Running apktool, you may want to take a look at the AndroidManifest.xml file to see the persmissions of the app"
echo "=================================================================================================================="
sudo apktool d $1

#dex2jar tool start
echo "Running dex2jar to translate the dex format to jar"
echo "=================================================================================================================="
sudo d2j-dex2jar $1
echo "Running jd-gui so that you can see the .jar file"
echo "=================================================================================================================="
jd-gui
fi

