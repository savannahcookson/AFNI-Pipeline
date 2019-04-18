#################################
## CABI Processing Stream Conversion Script
##
## Updated 20160617 by Savannah Cookson
## Fixed call to CSV file location
##
## Updated 20160328 by Savannah Cookson
## Fixed if statement and changed call to correct python
## script
##
## Updated 20160314 by Savannah Cookson
## Updated script to allow use of python script version
##
## Updated 20160204 by Savannah Cookson
## Incorporated XLS option for subject data
##
#################################

userID='scookson'
studyDirectoryName='Desktop/1804/'
setupFilename='CSV_DataFileNEW.csv'
rawDataLocation='/home/despoC/scookson/Desktop/1804/raw_data/'
fileType=1 #use 1 for original CSV setup; use 2 for updated XLSX version

#################################
## DO NOT EDIT BELOW THIS LINE ##
#################################

outDirectory='/home/despoC/'$userID'/'$studyDirectoryName
scripts_dir="/home/despoC/scookson/Desktop/tutorialScripts/permanent"

if [ $fileType == 1 ]; then
	
	echo Using CSV Setup...
	CSVLocation=$outDirectory'/'$setupFilename
	sh /home/despoC/scookson/Desktop/tutorialScripts/permanent/script_dicom_nii.sh $outDirectory $CSVLocation $rawDataLocation

else

	echo Using XLS Setup...
	dicom_nii_CABI.py $setupFilename $outDirectory $rawDataLocation 'raw_nii'

fi
