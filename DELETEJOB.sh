USERNUM=3311118

for (( k = 1; k <= 400; k++  ))

   do
   
	qdel $USERNUM
	USERNUM=$(($USERNUM+1))
  done
   

