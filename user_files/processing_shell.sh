#############################
##
## Created by Savannah Cookson 20150723
##
## The following script interfaces with the user to input the study-
## specific information that will be needed to produce and run the
## processing scripts via AFNI_PROC.py.
##
## Modified by Christine Godwin 20161007
## Updated to clarify that runPrefix input does not need to be changed
##
## Modified by Savannah Cookson 20160719
## Updated example entries in $subjects variable to better convey variable format
##
## Modified by Savannah Cookson 20160314
## Script modified to allow for user-defined naming for functional runs.
##
## Modified by Savannah Cookson 20151028
##
## Script modified to allow for acquisition sequence specification.
##
## Modified by Savannah Cookson 20150910
##
## Script was not passing subjID properly; rearranged inputs to scripts
## so that variable is passed through $subject and $studySuffix separately
## and $subjID is created from these directly within scripts that need that value.
## Also corrected misnamed studyDirectory variable call.
##
## Script now points to sync folder.
##
#############################

#############################
## User Inputs
#############################
userPath='/home/despoC/scookson'

scriptsPath='/home/despoC/scookson/Repositories/AFNI-Pipeline/permanent'

rawLoc='rawdata'

studyDirectory='Desktop/DemoTest'

studySuffix=demo #select an identifier for your study. This will be appended to the files/folders produced by the script.

blocksDesired="despike tshift align tlrc volreg blur mask scale" # Remove those you do NOT wish to run

runPrefix="fMRI_run" #set to the prefix ONLY for your run names, that is, the prefix of your run files in the raw_nii folders

acqSeq="alt+z" #set to the acquisition sequence for your data

blur=6 #set to 2x voxel width for standard applications

regressorNames='L R' #Symbolic names you would like to give each stimulus file in the order they appear in the stim folder

contrasts=("+L -R" "LeftVRight") #symbolic contrasts and labels. Should be entered in pairs with the symbolic expression first.

subjects=("1") # subjects you desire to run; should match the folder name in which the starting data appear

produceScripts=true #change to false if you do not wish to produce the scripts

runProcessing=false #change to false if you do not wish to run the processing scripts




#############################
## DO NOT EDIT BELOW THIS POINT UNLESS YOU KNOW WHAT YOU ARE DOING!
#############################


outDirectory=$userPath'/'$studyDirectory

if [ "$produceScripts" = true ];
then
	for subject in "${subjects[@]}" 

	do

		echo $subject # prints the current subject number for progress logging.

		sh $scriptsPath/AFNI_PROC.sh $subject $studySuffix $rawLoc "$blocksDesired" "$runPrefix" "$acqSeq" $blur "$regressorNames" "${contrasts[@]}"

	done
else
	echo 'Not producing scripts. Starting processing:'
fi

if [ "$runProcessing" = true ];
then

	for subject in "${subjects[@]}" 
	do

		sh $scriptsPath/parallel_proc.sh $subject $studySuffix $outDirectory $scriptsPath
		
	done
else
	echo 'Not running processing. Exiting script...'
fi








