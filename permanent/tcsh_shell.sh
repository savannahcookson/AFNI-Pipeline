###############
##
## Created by Savannah Cookson (4_tcsh_shell.sh)
##
## Documented by Savannah Cookson 20150629
## Encapsulation by Savannah Cookson 20150723
##
## Called by processing_shell.sh via parallel_proc.sh
## to run the tcsh script produced by AFNI_PROC
##
## DO NOT EDIT THIS FILE IF YOU DO NOT KNOW WHAT YOU ARE DOING!
##
###############

subjID=$1
analysisdirectory=$2

cd $analysisdirectory

tcsh -xef $subjID.tcsh 2>&1 | tee output.$subjID.tcsh



