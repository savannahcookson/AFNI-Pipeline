CREATED BY SAVANNAH COOKSON 20150629

MODIFIED BY CHRISTINE GODWIN 20161007
- Clarified that rname has a built-in prefix, only need to specify identifiers

MODIFIED BY SAVANNAH COOKSON 20160314
- Clarified naming structure for NIFTI files produced by the converter scripts.

The subject list is contained in a CSV (comma-separated values) file. 

The first line is a set of headers indicating what is contained in each column. 
	- subject: the identifier for each of your subjects. Typically the subject number, but does not have to be. Note that this will serve as the filename for each individual subject's converted data, and will trickle down through all of your analyses.
	- dicom_subj: the folder name within the parent folder containing all of the raw data that corresponds to a given subject's scan. These are the names outputted by the scanner. Do NOT include the forward slash ("/") at the end of the folder name.
	- dicom_anat: the name of the folder containing the anatomical scan DICOM files. This value can include wildcards.
	- r1: the names of the folders containing each run of functional MRI DICOM files. These values can include wildcards.
	- rname: the name you would like to give the converted NIFTI files for each run. It will be appended to the built-in prefix, which is 'fMRI_run'. The identifier should be the unique part of the name that identifies each particular file. Many people numbers for this part so that the formatting of the rnames is 'fMRI_run1', 'fMRI_run2', etc. 

Each line should represent a single run of data for a single subject. Because of the consistency of the format of the outputted data coming from the scanner, you can use wildcards to let you copy and paste much of the information for a single subject for every subject. Once you have set up your CSV file, you will need to go through each raw data folder and make sure that you have expressly indicated which run to use in the case that a scan needed to be repeated. Also double-check the spelling of the folder name containing your subject's scans; failure to check both of these steps will prevent the converter from completing that subject's NIFTI setup.
