ERNUM=0
   USERPREFIX='Job'
peak=0.99
step=0.49
for (( k = 1; k <= 2; k++  ))

   do
   
   echo $peak | bc -l
   for (( i = 1 ; i <= 200; i++ ))


  	 do

   	USERNUM=$(($USERNUM+1))

   	USERCREATE="$USERPREFIX$USERNUM"

   	qsub -N $USERCREATE -v inpeak=$peak run-matlab.sh
   	echo $USERCREATE
   done
   
   peak=$(echo $peak - $step | bc)
done

