#!/bin/bash -l

# Batch script to run a multi-threaded Matlab job on Legion with the upgraded
# software stack under SGE.
#
# Based on openmp.sh by:
# Owain Kenway, Research Computing, 20/Sept/2010
# Updated for RHEL 7, Oct 2015
# Updated for R2016b Jan 2017

# 1. Force bash as the executing shell.
#$ -S /bin/bash

# 2. Request ten minutes of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=4:0:0

# 3. Request 1 gigabyte of RAM.
#$ -l mem=1G

# 4. Select 12 threads (the most possible on Legion X and Y nodes).
#$ -pe smp 1

# 5. Reserve one Matlab licence - this stops your job starting and failing when no
#    licences are available.
#$ -l matlab=1

# 6. The way Matlab threads work requires Matlab to not share nodes with other
# jobs.




# 9. Set the working directory to somewhere in your scratch space.  This is
# a necessary step with the upgraded software stack as compute nodes cannot
# write to $HOME.
# Replace "<your_UCL_id>" with your UCL user ID :)
#$ -wd /home/uceexya/Scratch/Matlab_remote_jobs


# 10. Your work *must* be done in $TMPDIR 
cd $TMPDIR

# 11. Copy main Matlab input file and any additional files to TMPDIR

cp /home/uceexya/Scratch/Matlab_remote_jobs/defocusing_ucl/*.m .
# 12. Run Matlab job

module load xorg-utils/X11R7.7
module load matlab/full/r2016b/9.1
module list
echo ""
echo "Running matlab -nosplash -nodisplay xianhe"
echo ""
matlab -nosplash -nodesktop -nodisplay -nojvm -singleCompThread -r "peak = $inpeak; NFDMsim"

# 13. Preferably, tar-up (archive) all output files onto the shared scratch area
tar zcvf $HOME/Scratch/Output/files_from_job_${JOB_ID}.tgz $TMPDIR

# Make sure you have given enough time for the copy to complete!


