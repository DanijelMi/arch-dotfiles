#!/usr/bin/env bash
# Status script for dwm
# colours: 01:normal 02:white 03:red 04:green 05:yellow 06:blue
# 07:cyan 08:magenta 09:grey


# cpu(){
#     read cpu a b c previdle rest < /proc/stat
#     notify-send "$cpu $a $b $c $previdle $rest"
#     prevtotal=$((a+b+c+previdle))
#     sleep 0.5
#     read cpu a b c idle rest < /proc/stat
#     total=$((a+b+c+idle))
#     cpu="$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))"
#     printf "\x05%0*d\x01" 2 $cpu
# }

cpu(){
    read cpu a b c previdle rest <<< $(echo "$1 $2 $3 $4 $5")
    prevtotal=$((a+b+c+previdle))
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu="$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))"
    printf "\x05%0*d\x01" 2 $cpu
}
cpu_mark="$(cat /proc/stat)"


mem(){
    ram=$(free -m | grep Mem: | awk {'printf("%.0f", $3/$2 * 100.0)}')
    printf "\x07%0*d\x01" 2 $ram
}

timedate(){
    dte="$(date "+%H:%M:%S")"
    echo -en "\x09$dte\x01"
}

music(){
    pgrep mpd >/dev/null || return 0
    track="$(mpc -f "[%title% - %artist%]" | head -1)"
    echo -en "\x09$track\x01"
}

bat(){
    onl="$(grep "on-line" <(acpi -V))"
    charge="$(awk '{print +$4}' <(acpi -b))"
    if [[ ( -z $onl && $charge -gt 20 ) ]]; then
        echo -e "\x05B$charge"
    elif [[ ( -z $onl && $charge -le 20 ) ]]; then
        echo -e "\x05B$charge"
    else
        echo -e "\x08C$charge"
    fi
}

# hdd(){
#     hd=( $(awk '
#         {i=$5} /boot/ {a=i}; /root/ {b=i}; /home/ {c=i}; /media/ {d=i}
#         END {if (NR==10) print a,b,c,d; else print a,b,c}
#                ' <(df -P)) )
#     drives="${#hd[@]}"
#     if [[ "$drives" -eq 3 ]]; then
#         echo -e "\x08${hd[@]}\x01"
#     else
#         echo -e "\x08${hd[@]:0:3}\x06${hd[@]:3:1}\x01"
#     fi
# }

pac(){
    pup="$(pacman -Qqu | wc -l)"
    if [ $pup -gt 0 ]; then 
        echo -en "\x05Outdated:$pup\x01"
    else
        echo -en ""
    fi
}

# netUP(){
#     T1_RX=$(cat /sys/class/net/enp4s0f2/statistics/rx_bytes)
#     T1_TX=$(cat /sys/class/net/enp4s0f2/statistics/tx_bytes)
#     sleep 1
#     T2_RX=$(cat /sys/class/net/enp4s0f2/statistics/rx_bytes)
#     T2_TX=$(cat /sys/class/net/enp4s0f2/statistics/tx_bytes)
#     echo "$(( ( T2_RX-T1_RX ) / 1000))"
#     echo "$(( ( T2_TX-T1_TX ) / 1000))"
# }

netdown(){
    NEW_RX=$(cat /sys/class/net/enp4s0f2/statistics/rx_bytes)
    printf "\x0a%0*d\x01" 3 $(( ($NEW_RX-$1)/1000 ))
}
netdown_mark=0

netup(){
    NEW_TX=$(cat /sys/class/net/enp4s0f2/statistics/tx_bytes)
    printf "\x0b%0*d\x01" 3 $(( ($NEW_TX-$1)/1000 ))
}
netup_mark=0


    # dependency: sysstat
    # mpstat 1 1 | awk '/^Average/ {print 100-$NF,"%"}'

# xsetroot -name "$(music) $(bat) • CPU $(cpu) MEM $(mem) • HDD $(hdd) \
# • EML $(eml) PKG $(pac) AUR $(ups)$(aur) • NET $(int) • $(dte) "

UTC=0   # Forces slower-updating widgets to render immedeately at start
[[ $(($UTC % 2)) -eq 0 ]] && mem=$(mem)

### MAIN EXEC
cpu=$(cpu $cpu_mark)  # cpu measurement internally uses 0.5 sec sleep
cpu_mark="$(cat /proc/stat)"
timedate=$(timedate)
[[ $(($UTC % 2)) -eq 0 ]] && music=$(music)
bat=$(bat)
[[ $(($UTC % 30)) -eq 0 ]] && pac=$(pac)
netdown=$(netdown $netdown_mark)
netdown_mark=$(cat /sys/class/net/enp4s0f2/statistics/rx_bytes)
netup=$(netup $netup_mark)
netup_mark=$(cat /sys/class/net/enp4s0f2/statistics/tx_bytes)

xsetroot -name "$music$netdown$netup$pac$bat$mem$cpu$timedate"
UTC=$(date +%s)
sleep 1