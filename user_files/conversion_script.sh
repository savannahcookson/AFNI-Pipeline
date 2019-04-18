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

userPath='/home/despoC/scookson'
scriptsPath='/home/despoC/scookson/Repositories/AFNI-Pipeline/permanent'
studyDirectoryName='Desktop/DemoTest'
setupFilename='exampleList_CSVversion.csv'
rawDataLocation='/home/despoC/scookson/Repositories/AFNI-Pipeline/tutorial/rawData'
fileType=1 #use 1 for original CSV setup; use 2 for updated XLSX version (in progress)

#################################
## DO NOT EDIT BELOW THIS LINE ##
#################################

outDirectory=$userPath'/'$studyDirectoryName

if [ $fileType == 1 ]; then
	
	echo Using CSV Setup...
	CSVLocation=$outDirectory'/'$setupFilename
	sh /home/despoC/scookson/Desktop/tutorialScripts/permanent/script_dicom_nii.sh $outDirectory $CSVLocation $rawDataLocation

else

	echo Using XLS Setup...
	dicom_nii_CABI.py $setupFilename $outDirectory $rawDataLocation 'raw_nii'

fi
