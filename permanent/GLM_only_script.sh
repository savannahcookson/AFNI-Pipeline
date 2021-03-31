#############################
##
## Created 20160427 by Savannah Cookson
##
## The following script runs the afni_proc.py function of AFNI
## for each subject indicated in the for loop to generate a
## GLM-only analysis script for each sub. This script is called by the
## glm_only_shell.sh script. The purpose of this script is to allow
## users to rerun the first-level analysis without reprocessing the data.
##
## WARNING: DO NOT EDIT THIS FILE UNLESS YOU KNOW WHAT YOU ARE DOING!
##
#############################

############
## Organize user inputs and format for insertion
############
subject="$1"
studySuffix="$2"
analysisSuffix="$3"
stimLabels="$4"
shift 4
contrasts=("${@}")

subjID=$subject'_'$studySuffix

############
## Intelligently identifies the contrast expressions and labels and total number of contrasts.
############
errorCatch=false
if [ $[${#contrasts[@]}%2] -eq 0 ];
then
	contrastScript=$''
	declare -i i
	i=0
	while [ $i -le $[$[${#contrasts[@]}/2]-1] ]
	do
		expression="${contrasts[$[$[i*2]]]}"
  echo $expression
		label=${contrasts[$[i*2]+1]}
  echo $label

		contrastScript="$contrastScript"$'\n-gltsym '"'"'SYM: '"$expression""'"' \'$'\n-glt_label '$[i+1]' '$label' \'
	

		let 'i += 1'

	done

	addtlCons=''
	if [ $i -gt 10 ];
	then
		addtlCons=' \'$'\n-num_glt '$i' \'
	fi
else
	echo 'incorrect number of items entered for one or more contrasts'
	errorCatch=true
fi

############
## The following portion of the script formats and then runs the afni_proc.py command.
############
if $errorCatch;
	then
	echo 'script failed; check your contrasts.'
else 

echo -e 'afni_proc.py \
-subj_id '${subjID}"'"_"'"${analysisSuffix}' \
-script '${subjID}"'"_"'"${analysisSuffix}'.tcsh \
-out_dir '${subjID}"'"_"'"${analysisSuffix}'.results \
-dsets '${subjID}'.results/all_runs.'${subjID}'+tlrc.HEAD \
-'${blocks}' mask regress \
-copy_files '${subjID}'.results/anat_final.'${subjID}'+tlrc.HEAD \
-regress_censor_outliers 0.1 -regress_censor_motion 0.2 \
-regress_motion_file '${subjID}'.results/dfile_rall.1D \
-regress_stim_times '${subjID}'.results/stimuli/*.1D \
-regress_stim_types AM2 \
-regress_stim_labels '"${stimLabels}"' \
-regress_basis '"'"'dmBLOCK'"'"' \
-regress_local_times \
-regress_opts_3dD \'"$addtlCons""$contrastScript"'
-float \
-jobs 4 \
-regress_est_blur_epits \
-regress_est_blur_errts \
-regress_run_clustsim no \
-bash' > temp.sh

sh temp.sh
#rm temp.sh


fi
