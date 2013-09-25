############################################################################
############################################################################
## Basic Linux Commands
## Johns Hopkins Biostatistics Computing Club
## Elizabeth Sweeney
## Septemeber 26, 2013
############################################################################
############################################################################
############################################################################
## On a MAC, first open the terminal
## To temporarily change your shell to bash, just type bash in the terminal
## To permanantly change go to Terminal >> Preferences; click Command
## (complete path) and type /bin/bash
############################################################################

bash

############################################################################
## Print working directory
############################################################################

pwd

############################################################################
## Print the date
############################################################################

date

############################################################################
## Store the date as a variable 
############################################################################

today='date'

echo $today


today=$(date)

echo $today

echo "Today is $today"

############################################################################
## A neat trick -- brace expanision
############################################################################

echo {one,two,red,blue}fish

echo 10{1,2,3}


############################################################################
## Doing a little bit of math
## We will type this into http://explainshell.com
############################################################################

expr 99 + 10

solution=$(expr 99 + 10)

echo $solution


############################################################################
## Move to Working Directory For Demo 
############################################################################

cd ~/Linux_Tutorial/2013


############################################################################
## List of files in the current directory 
############################################################################

ls

ls -l

############################################################################
## Sort by modification time 
############################################################################

ls -lv

############################################################################
## Making a new directory
############################################################################

mkdir Comp_Club_2013

############################################################################
## Navigating through directories
############################################################################

##move up a directory
cd Sample_Files

##move down a directory
cd ..

##move down a directory and then up to another one
cd ../2012

##move down two directories and then up to another one
cd ../../

##go home
cd

############################################################################
## Make a new file using vi Editor
############################################################################


cd ~/Linux_Tutorial/2013/Sample_Files

##make a new file using vi editor
vi file6.txt

##insert text
i

##save and quit, press esc then
ZZ

##reopen file
vi file6


############################################################################
## Moving Files
############################################################################

mv file1.txt  More_Files/File_1/new_name_file.txt

cd More_Files/File_1/

mv new_name_file.txt  ../../file1.txt

cd ..

##move a directory
mv File_1 File_2/File_1

mv File_2/File_1 File_1

cd ..

##use the * command

mv file* More_Files

cd More_Files

indices=$(seq 5)

for index in $indices
do
    mv 'file'$index'.txt' 'File_'$index/'file'$index
    echo $index
done

############################################################################
## Copying Files
############################################################################

cd File_1

cp file1 file1.1

cd ..

cp -r File_1 File_1.1

############################################################################
## Removing Files
############################################################################

rm  file6.txt

rm *.txt

rm *

############################################################################
## Copying files from the cluster onto your computer (or the other way)
############################################################################

##copy a directory from the cluster to your computer
scp -r /Users/ane/Desktop/Rscript emsweene@enigma2.jhsph.edu:Comp_Club

##copy a file from the cluster to your computer
scp -r emsweene@enigma2.jhsph.edu:Comp_Club /Users/ane/Desktop/


############################################################################
## Changing Permissions on a file
## Good resource: http://www.linux.com/learn/tutorials/309527-understanding-linux-file-permissions
############################################################################

cd ~/Linux_Tutorial/2013

ls -l

chmod 777 Bash_20130916.pdf

chmod 777 *


############################################################################
## Using Rscript (needs files batch.sh and Code.R)
############################################################################

#!/bin/bash

cd ~/Linux_Tutorial/2012/Rscript

### Set the seeds
seeds='395  
444  
881  
894  
727  
678  
992   
65  
957  
976'

for seed in $seeds
do

./batch.sh $seed

echo $seed
done

############################################################################
## Head and Tail of a file
############################################################################

##first 10 lines of the file
head 395_output

##last 10 lines of a file
tail 395_output

############################################################################
## Using the ls function to get things done
############################################################################

#!/bin/bash

cd /dexter/disk1/smart/msmri/Hopkins_MRI/Healthy_Brain_Data_process/flair/

#get study ids
array=(`ls`)
len=${#array[*]}
i=0
while [ $i -lt $len ]; do
array[$i]=${array[$i]:0:7}
let i++
done

i=0
while [ $i -lt $len ]; do
subjscan=${array[$i]}

##make brain maks using BET##
cd /dexter/disk1/smart/msmri/Hopkins_MRI/Healthy_Brain_Data_process/N3_CoReg_Healthy_with_Spectre/

qsub -cwd -l mem_free=15G,h_vmem=16G OASIS_mysubscript.sh $subjscan

let i++
done

############################################################################
## Storing Variables
############################################################################

i=5

##use fsl to calculate the mean over a brain image
fslstats ${array[$i]}'flair.nii.gz' -M

##store the computation as the variable mean_flair
mean_flair=`fslstats ${array[$i]}'flair.nii.gz' -M`

##echo the variable
echo $mean_flair


############################################################################
## HELP
############################################################################

man find

##type control Z to exit

############################################################################
## The find command
############################################################################

##find files for a particular subject
find ~/Linux_Tutorial -name file*

##find files that were modified between 29 and 6 minutes ago
find ~/ -mtime 0

##please note ~ if you use the find command on the cluster, do not start at the top!!  Start from 
##your home directory or lower! 
