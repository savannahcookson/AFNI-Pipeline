#!/usr/bin/env python
#
# Converting dicom to 4D nii
#
# Copyright @ CABI, Jaemin Shin, PhD, jaemins@gatech.edu
# 2015-10-20
# 2016-02-17


# python dicom_nii_CABI.py $filename $analysisdirectory $dicom_root $nii_folder
#filename = "subject_CABI.xlsx"
#analysisdirectory = "~/CABI/nii_orig"
#dicom_root= "/data1/rawdata/public/AFNIProcDemoData/"


#-----------------------------------------------------------------------------------------
# DO NOT EDIT THE BELOW UNLESS YOU KNOW WHAT YOU ARE DOING
#-----------------------------------------------------------------------------------------

import xlrd
import os
import sys

total = len(sys.argv)

filename = str(sys.argv[1])
analysisdirectory = str(sys.argv[2])
dicom_root = str(sys.argv[3])
nii_folder = str(sys.argv[4])
print ("---------------------------------------------")
print ("Running %s" % str(sys.argv[0]))
print ("version 2016-02-17")
print ("---------------------------------------------")
print ("Spreadsheet : %s" % filename)
print ("Directory   : %s" % analysisdirectory)
print ("Dicom_root  : %s" % dicom_root)
print ("Subfolder   : %s" % nii_folder)
print ("---------------------------------------------")



sheet = xlrd.open_workbook(filename).sheet_by_index(0)
num_rows = sheet.nrows


for x in range(1, num_rows):
	subject = sheet.cell(x,0).value
	if type(subject) == float:
		subject = int(subject)

	dicom_subj = sheet.cell(x,1).value
	dicom_anat = sheet.cell(x,2).value
	r1 = sheet.cell(x,3).value


	if subject != 0:
		
		# T1 anatomical scan conversion
		# nii_name = T1 <-- Hard-coded for CABI users per Savannah's request 
		if sheet.cell(x,2).value != "":
				#print sheet.cell(x,y).value
				#print sheet.cell(x,y+1).value
				
				dicom_folder = sheet.cell(x,2).value
				nii_name = "T1"
				buf = "shin_dicom2nii.sh %s %s %s %s %s %s %s" % \
				(analysisdirectory, subject,nii_name, dicom_root, dicom_subj, dicom_folder, nii_folder)
				os.system(buf)
	
		for y in range(3, sheet.ncols, 2):
		
			if sheet.cell(x,y).value != "":
				#print sheet.cell(x,y).value
				#print sheet.cell(x,y+1).value
				
				dicom_folder = sheet.cell(x,y).value
				if sheet.cell(x,y+1).value == "":
					print "ERROR!  No NII filename for the dicom folder: %s" % (dicom_folder)
					break
				nii_name = sheet.cell(x,y+1).value

				buf = "shin_dicom2nii.sh %s %s %s %s %s %s %s" % \
				(analysisdirectory, subject,nii_name, dicom_root, dicom_subj, dicom_folder, nii_folder)
				if nii_name != 0:
					#print buf
					os.system(buf)

					
