############################################################################
############################################################################
## Basic Linux Commands
## Johns Hopkins Biostatistics Computing Club
## Elizabeth Sweeney
## November 29, 2012
############################################################################
############################################################################

############################################################################
## Print working directory
############################################################################

pwd

############################################################################
## List of files in the current directory 
############################################################################

ls

ls -l

############################################################################
## Making a new directory
############################################################################

mkdir Comp_Club

############################################################################
## Navigating through directories
############################################################################

##move up a directory
cd Comp_Club

##move down a directory
cd ..

##move down a directory and then up to another one
cd ../test

##move down two directories and then up to another one
cd ../../

##go home
cd

############################################################################
## Make a new file using vi Editor
############################################################################

##make a new file using vi editor
vi file1.txt

##insert text
i

##save and quit, press esc then
ZZ

##reopen file
vi file1

############################################################################
## Moving Files
############################################################################

mkdir Move_it

mv file1.txt  Move_it/file.txt

mv file1.txt  ../new_name_file.txt

##move a directory
mv Move_it Move_it_here

############################################################################
## Copying Files
############################################################################

cp file2 Move_it_here/

cp file* Move_it_here/

############################################################################
## Removing Files
############################################################################

rm  file1.txt

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
## Good resource: http://www.tuxfiles.org/linuxhelp/filepermissions.html
############################################################################

ls -l

chmod 777 Code.R

chmod 777 *


############################################################################
## Using Rscript (needs files batch.sh and Code.R)
############################################################################

 #!/bin/bash

### PRIMARY ANALYSIS
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
   qsub -N withinbs -cwd -l mem_free=.25G,h_vmem=.5G,h_fsize=1G,h_stack=1M batch.sh $seed 
   
done

############################################################################
## Head and Tail of a file
############################################################################

##first 10 lines of the file
head 395_output

##last 10 lines of a file
tail 395_output

##look at what is in a file
less 395_output

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
## Using wget
############################################################################

##Download the title page of my website and call it index.html
wget http://www.elizabethmargaretsweeney.wordpress.com

##Dowload the entire contents of my website
wget -r -l 0 http://www.elizabethmargaretsweeney.wordpress.com

############################################################################
## HELP
############################################################################

man find

############################################################################
## The find command
############################################################################

##find files for a particular subject
find ~/ -name 1000101*

##find files that were modified between 29 and 6 minutes ago
find ~/ -mtime 0

##please note ~ if you use the find command on the cluster, do not start at the top!!  Start from 
##your home directory or lower! 
