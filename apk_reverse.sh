#!/bin/bash

if [ -z "$1" ]
then echo "The syntax is ./apk_reverse.sh path_till_the_apk" && ps -ef | grep apk_reverse.sh | grep -v grep | awk '{print $2}' | xargs kill
else

#creating the folder where the reverse engineering results will be stored (per application)
echo "Please specify the name of the folder that you want to store the output of this process (advice: choose the name and release of the app)"
read folder_name
mkdir -v $folder_name
cd $folder_name

echo "--------------------------------------------------------------------------------------------------------------"
echo "Hello, i am initiating the reverse engineering session"
echo "Be aware that depending on the distro you might have to insert this script to a specific file (i.e. dex2jar path)"
echo "=================================================================================================================="

#apktool start
echo "Running apktool"
echo "--------------------------------------------------------------------------------------------------------------"
sudo apktool d $1
echo "--------------------------------------------------------------------------------------------------------------"
echo "Running this operation in order to check the AndroidManifest.xml file for the tag FIDO"
echo "=================================================================================================================="
echo "Please specify the name of the folder produced by the apktool that cointains the AndroidManifest.xml file"
read apktool_produced_folder
cd $apktool_produced_folder
echo "--------------------------------------------------------------------------------------------------------------"
echo "If fido was found you'll see the occuracies (repsective line in the .xml) below:"
echo "--------------------------------------------------------------------------------------------------------------"
grep -o -i -n -C 2 fido AndroidManifest.xml
cd ..
echo "=================================================================================================================="

#dex2jar tool start
echo "Running dex2jar to translate the dex format to jar"
echo "=================================================================================================================="
sudo d2j-dex2jar $1
#echo "Running jd-gui so that you can see the .jar file"
echo "--------------------------------------------------------------------------------------------------------------"

#jd-gui

echo "Running FIND_FIDO operation in order to check the .jar files for classses with the keyword FIDO"
echo "=================================================================================================================="

jar_file_name=$(ls | grep .jar)
jar -tvf $jar_file_name | grep fido > keyword_hints.txt


fi
