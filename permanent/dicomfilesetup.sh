#!/usr/bin/env bash

###################################################################
##---Convert Dicom to nii-------------------------------------##
###################################################################
# Created by Savannah Cookson 20210226
#
# Modified from shin_dicom2nii by Jaemin Shin, PhD (jaemins@gatech.edu), Center for Advanced Brain Imaging
#
## directory where scripts are located
analysisdirectory=$1
dicom_root=$2
subject=$3
dicom_subj=$4
data_name=$5
dicom_scan=$6
scan_name=$7

subject_out=$analysisdirectory/$subject
data_out=$subject_out/$data_name
dicom_loc=$dicom_root/$dicom_subj/$dicom_scan
scan_loc=$data_out/$scan_name


if [ ! -d $subject_out ]; then
	mkdir $subject_out
fi

if [ ! -d $data_out ]; then
	mkdir $data_out
fi

cp -R $dicom_loc $scan_loc
