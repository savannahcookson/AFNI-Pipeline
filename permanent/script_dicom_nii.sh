#!/usr/bin/env bash
##########################################################################################
## Preprocessing script USING Sung Grid Engine
##
## Modified by Savannah Cookson 20210226
## Restructuring conversion pipeline to simplify setup and integrate
## updated dcm2niix function
##
## Modified by Jaemin Shin
## Written by Maarten Mennes & Michael Milham
## for more information see www.nitrc.org/projects/fcon_1000
##
## Modified by Savannah Cookson 20160719
## Removed automatic appending of "s" to beginning of subject number
##
## Modified by Savannah Cookson 20160707
## Changed file structure to direct all converted data to "raw_nii" folder
##
## Modified by Savannah Cookson 20150629
## Added documentation to script for future users.
##
## Modified by Savannah Cookson 20150626
## Script now handles dicom paths with spaces in the path name.
## This was an issue with the way bash variables are passed to unix commands.
## Putting the original variable string represents the full string with space in the
## variable. This change was made in conjunction with a change to 0_dicom2nii.sh.
##
## Modified by Savannah Cookson 20150910
## Script now points to sync folder
##
## Fix found at: ubuntuforums.org/showthread.php?t=1488186
##
##########################################################################################

####################
## NOTE: All file paths must include the full path name; do NOT end with a forward slash ("/").
## Quotations are used to indicate a filepath that may have spaces in the folder names.
####################

####################
## scripts directory: File path for the folder containing this script and shin_dicom2nii.sh
####################
scripts_dir=$1

####################
## analysis directory: Folder in which you want your subject data to be saved. Data will 
## be automatically sorted into subfolders for each subject.
####################
analysisdirectory=$2

####################
## Subject list and parameters: File path of CSV file (see exampleList.csv)
####################
subj_info=$3

####################
## Dicom path: Filepath of parent folder containing the raw data referenced in CSV file (col 2)
####################
dicom_root=$4

##########################################################################################
##---START OF SCRIPT--------------------------------------------------------------------##
##---NO EDITING BELOW UNLESS YOU KNOW WHAT YOU ARE DOING--------------------------------##
##########################################################################################
mkdir -p $analysisdirectory
#tr -d '\r' < $subj_info > tm---temp.csv
#subj_info=tm---temp.csv

#################################################################################

subnum=0
OLDIFS=$IFS
IFS=,
#[ ! -f $subj_info ] && { echo "$subj_info file not found"; exit 99; }

echo 'Copying Dicoms'

while read subject dicom_subj data_name scan_folder scan_name; do
subnum=$((subnum +1))

if [[ $subnum -gt 1 ]] && [[ $subnum -lt 2000 ]] && [[ $subject != '0' ]] && [[ ! -z $subject ]]; then
	echo "--------------------------------------------------------------------------------"
	echo " $subject	--	$dicom_subj	--	$scan_name "
	echo "--------------------------------------------------------------------------------"
	sh ${scripts_dir}/dicomfilesetup.sh ${analysisdirectory} ${dicom_root} ${subject} ${dicom_subj} ${data_name} ${scan_folder} ${scan_name}

	echo 'Running Conversion'

	data_loc=${analysisdirectory}/${subject}/${data_name}
	dcm2niix -f %f $data_loc/${scan_name}

	mv $data_loc/$scan_name/${scan_name}.nii $data_loc
	rm -r $data_loc/$scan_name

fi
done < $subj_info

IFS=$OLDIFS
