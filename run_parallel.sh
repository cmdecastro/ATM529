#!/bin/bash

source  /linuxapps/anaconda3/anacondaenv.bash

# $1 means that the script need one input from outside.
#myvar=$1
#echo $1
#echo "_________________________________________"
#myvar="tem"
myvar="q"
diri_input="/free2/cd859229/era5_q/"

# or we can commmend the previous statement and use one of the following statments.

# pressure level variables
#myvar="vwind"
#myvar="wwind"
#myvar="ght"
#myvar="q"
#myvar="tem"

if [ $myvar == 'q' ];then
    parm_name='specific_humidity'
fi

if [ $myvar == 'tem' ];then
    parm_name='temperature'
fi

rm -f list_files.txt
COUNTER=0
for (( c=1979; c<=2020; c++ ))
  do
   for (( month=1; month<=12; month++ ))
      do
        echo "Checking $myvar at $c, Month $month"
        myfile="${diri_input}${parm_name}_${c}_${month}.nc"
        if [ ! -f $myfile ];then   # if #1
         echo $myfile >> list_files.txt

        if [[ $myvar == 'uwind' || \
              $myvar == 'vwind' || \
              $myvar == 'wwind' || \
              $myvar == 'tem'   || \
              $myvar == 'ght'   || \
              $myvar == 'q' ]];then

            ipython download_hourly_pressure.py  $c $month $diri_input $parm_name >& logme/${parm_name}_${c}_${month}
        fi

	echo ' Requesting file # .... '${COUNTER}
    COUNTER=$[$COUNTER +1]
         # limit on the file to donwloaded simultaneosuly
         #https://confluence.ecmwf.int/display/CKB/Climate+Data+Store+%28CDS%29+documentation
          if (( ${COUNTER} % 10 == 0 ));then
             echo 'we are inside the if condition waiting for the files from ECWMF ....'
             echo "files are :"
             while read p; do
                while [ ! -e $p ] # iterate sleeping till the file is downloaded.
                do
                  sleep 180 # 3 min
                  echo ' waiting for  ....'${p}
                done
               echo "we get "${p}
               done <list_files.txt
               rm list_files.txt
          fi
       else  # if #1
       echo 'File exist'${myfile}
       fi # if #1
        done
      done
