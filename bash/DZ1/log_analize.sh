#!/bin/bas
loadavg1_fail=$(tail -n $((2*60/5)) $1 | awk 'BEGIN{LF=0} {if ($2 >= 1) LF++} END {print LF}')
memfree_fail=$(tail -n $((3*60/5)) $1 | awk 'BEGIN{MF=0} {if ($5/$6*100 >= 60) MF++} END {print MF}')
diskfree_fail=$(tail -n $((5*60/5)) $1 | awk 'BEGIN{DF=0} {if ($7/$8*100 >= 60) DF++} END {print DF}')
if [[ $loadavg1_fail >=1 ]]; then
    echo "loadavg more then 1.0"
    ((return_code++))
fi
if [[ $memfree_fail >=1 ]]; then
    echo "memfree more then 60%"
    ((return_code++))
fi
if [[ $diskfree_fail >=1 ]]; then
    echo "diskfree more then 60%"
    ((return_code++))
fi
exit $return_code