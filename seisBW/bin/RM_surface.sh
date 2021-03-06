#!/bin/bash
# surface wave removal
nt=$1

#### parameters for dipfiltering
slope1=-0.0011
slope2=-0.0009
slope3=-0.0008
slope4=0.0000
slope5=0.0007
slope6=0.0009
slope7=0.0011
amp1=0.0
amp2=0.0
amp3=1.0
amp4=1.0
amp5=1.0
amp6=0.0
amp7=0.0
bias_neg=-0.00085
bias_pos=0.00080

######################## X comp ###################################################################################
input_file=OUTPUT_FILES/Ux_file_single.bin
output_file=OUTPUT_FILES/Ux_file_single_filtered.bin

  ## convert binary file to su file
  ./cwp/suaddhead<$input_file ns=$nt>file1.su
  # edit keywords
 ./cwp/sushw<file1.su key=dt,d2 a=500,25>file2.su

 ## dip filtering
 # taper
  ./cwp/sutxtaper<file2.su tbeg=1000 tend=1000 taper=5 key=tr tr1=20 tr2=20 ntr=361 >file3.su
 # band-pass filter 
  ./cwp/sufilter f=1,3,16,20 amps=0,1,1,0 <file3.su>file4.su
 # anti-aliasing slope filter
 ./cwp/sudipfilt<file4.su slopes=$slope1,$slope2,$slope3,$slope4 amps=$amp1,$amp2,$amp3,$amp4 bias=$bias_neg>file5.su
 ./cwp/sudipfilt<file5.su slopes=$slope4,$slope5,$slope6,$slope7 amps=$amp4,$amp5,$amp6,$amp7 bias=$bias_pos>file6.su
 # tapering the final result
  ./cwp/sutxtaper<file6.su tbeg=500 tend=500 taper=5 key=tr tr1=20 tr2=20 ntr=361>file7.su

  ## convert su file back to binary file
  ./cwp/sustrip<file7.su>$output_file head=null outpar=tty ftn=0

######################## Z comp ##################################################################################
input_file=OUTPUT_FILES/Uz_file_single.bin
output_file=OUTPUT_FILES/Uz_file_single_filtered.bin
 
  ## convert binary file to su file
  ./cwp/suaddhead<$input_file ns=$nt>file1.su
  # edit keywords
 ./cwp/sushw<file1.su key=dt,d2 a=500,25>file2.su

 ## dip filtering
 # taper
  ./cwp/sutxtaper<file2.su tbeg=1000 tend=1000 taper=5 key=tr tr1=20 tr2=20 ntr=361 >file3.su
 # band-pass filter 
  ./cwp/sufilter f=1,3,16,20 amps=0,1,1,0 <file3.su>file4.su
 # anti-aliasing slope filter
 ./cwp/sudipfilt<file4.su slopes=$slope1,$slope2,$slope3,$slope4 amps=$amp1,$amp2,$amp3,$amp4 bias=$bias_neg>file5.su
 ./cwp/sudipfilt<file5.su slopes=$slope4,$slope5,$slope6,$slope7 amps=$amp4,$amp5,$amp6,$amp7 bias=$bias_pos>file6.su
 # tapering the final result
  ./cwp/sutxtaper<file6.su tbeg=500 tend=500 taper=5 key=tr tr1=20 tr2=20 ntr=361>file7.su

  ## convert su file back to binary file
  ./cwp/sustrip<file7.su>$output_file head=null outpar=tty ftn=0

##################################################################################################################

