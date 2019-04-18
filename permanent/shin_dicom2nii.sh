#!/usr/bin/env bash

###################################################################
##---Convert Dicom to nii-------------------------------------##
###################################################################
# Updated 10/14/2014: Multiple folders (t1_MPRAGE)
# Updated 08/28/2015
# Updated 09/09/2015: Check/copy dcm2nii.ini 
# Updated 09/23/2015: DTI bvec/bval 
# Written by Jaemin Shin, PhD (jaemins@gatech.edu), Center for Advanced Brain Imaging
#
## directory where scripts are located
scriptsdir=$1
## full/path/to/site
analysisdirectory=$2
## full/path/to/site/subject_list
subject=$3
## name of anatomical scan (no extension)
nii_name=$4
## name of resting-state scan (no extension)
dicom_root=$5
dicom_subj=$6
dicom_folder=$7
nii_folder=$8
fname=$9

if [ ! -z "$nii_folder" ]; then
   	nii_folder=${nii_folder%/} #remove '/' at the end
	nii_folder=/${nii_folder}
fi
echo $nii_folder

if [ ! -d ~/.dcm2nii ]
then
mkdir ~/.dcm2nii/
cp -f /home/public/dcm2nii/dcm2nii.ini ~/.dcm2nii/
fi

echo ${analysisdirectory}${nii_folder}/${nii_name}.nii
if [ ! -f ${analysisdirectory}${nii_folder}/${nii_name}.nii ]
then
if [ ! -f ${analysisdirectory}${nii_folder}/${nii_name}.nii.gz ]
then

cd ${dicom_root}
input=$dicom_subj
output=$analysisdirectory

input=${input%/} #remove '/' at the end
infname=${input} #*/}
output=${output%/} #remove '/' at the end

inputfull=${input}/${dicom_folder}
test1=`echo $inputfull`
test2=`echo $inputfull | tr -d ' '`

if [ "$test1" == "$test2" ]
then


mkdir -p ${output}/${infname}
if [ -d $input/${dicom_folder} ]
then


cp -R ${input}/${dicom_folder} ${output}/${infname}/
cd ${output}/${infname}
#echo ------------------------------------------------------------
#echo ${input}/${dicom_folder}
#echo ${output}/${infname}/
#echo ${output}/${infname}
#echo ------------------------------------------------------------

echo ------------------------------------------------------------
echo Written by Jaemin Shin, PhD, jaemins@gatech.edu
echo 'Center for Advanced Brain Imaging'
echo version 09/23/2015
echo ------------------------------------------------------------
echo Converting Dicom to nii...
echo ${analysisdirectory}${nii_folder}/${nii_name}.nii
echo ------------------------------------------------------------

pwd
dcm2nii -d n -e n -n y -i n -n y -p n -r y -x n -g n ./

mkdir -p ${analysisdirectory}
mkdir -p ${analysisdirectory}${nii_folder}
#echo ------------------------------------------------------------
#echo ../${subject}${nii_folder}
#echo  ${dicom_folder}/00001.nii
#echo  ../${subject}${nii_folder}/${nii_name}.nii
#echo ${infname}
#echo ------------------------------------------------------------
mv ${dicom_folder}/${fname}.nii ${analysisdirectory}${subject}${nii_folder}/${nii_name}.nii

#if [ -f ${dicom_folder}/00001.bval ]
#then
#mv ${dicom_folder}/00001.bval ${analysisdirectory}${subject}${nii_folder}/${nii_name}.bval
#mv ${dicom_folder}/00001.bvec ${analysisdirectory}${subject}${nii_folder}/${nii_name}.bvec
#fi

cd ${analysisdirectory}
rm -rf ${infname}

else 
	echo ------------------------------------------------------------
	echo ERROR: Directory does NOT exist
	echo ${input}/${dicom_folder}
fi


else
	echo ------------------------------------------------------------
	echo ERROR: Multiple folders
	echo $test1
fi # if [ "$test1" == "$test2" ]


fi # if [ ! -f ${analysisdirectory}/${subject}${nii_folder}/${nii_name}.nii ]
fi # if [ ! -f ${analysisdirectory}/${subject}${nii_folder}/${nii_name}.nii.gz ]
