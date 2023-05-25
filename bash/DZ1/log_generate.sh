log_file=sys_status.log
echo timestamp loadavg1 loadavg5 loadavg15 memfree memtotal diskfree disktotal > $log_file
while true; do
        stamp=$(date +%T)
        loadavg=$(cat /proc/loadavg | awk '{print $1,$2,$2}')
        mem=$(free -b | grep Mem |awk '{print $4,$2}')
        disk=$(df | grep -E '*/$' | awk '{print ($4-$3),$4}')


        echo $stamp $loadavg $mem $disk >> $log_file
        sleep 5
done