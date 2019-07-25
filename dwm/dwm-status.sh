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
#     printf "%0*d" 2 $cpu
# }

cpu(){
    read cpu a b c previdle rest <<< $(echo "$1 $2 $3 $4 $5")
    prevtotal=$((a+b+c+previdle))
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu="$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))"
    printf "%0*d" 2 $cpu
}
cpu_mark="$(cat /proc/stat)"


mem(){
    ram=$(free -m | grep Mem: | awk {'printf("%.0f", $3/$2 * 100.0)}')
    printf "%0*d" 2 $ram
}

timedate(){
    dte="$(date "+%H:%M:%S")"
    echo -en "$dte"
}

music(){
    pgrep mpd >/dev/null || return 0
    track="$(mpc -f "[%title% - %artist%]" | head -1)"
    echo -en "$track"
}

bat(){
    onl="$(grep "on-line" <(acpi -V))"
    charge="$(awk '{print +$4}' <(acpi -b))"
    if [[ ( -z $onl && $charge -gt 20 ) ]]; then
        echo -e "B$charge"
    elif [[ ( -z $onl && $charge -le 20 ) ]]; then
        echo -e "B$charge"
    else
        echo -e "C$charge"
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
        echo -en "Outdated:$pup"
    else
        echo -en ""
    fi
}


net_if_array=($(ip -o -4 route show to default | awk '{print $5}'))
net_sample(){
    # DOWN
    NEW_RX=()
    for i in "${!net_if_array[@]}"; do
        #echo "${net_if_array[$i]}"
        NEW_RX[$i]=$(cat /sys/class/net/${net_if_array[$i]}/statistics/rx_bytes)
        #echo ${NEW_RX[$i]}
    done
    # UP
    NEW_TX=()
    for i in "${!net_if_array[@]}"; do
        #echo "${net_if_array[$i]}"
        NEW_TX[$i]=$(cat /sys/class/net/${net_if_array[$i]}/statistics/tx_bytes)
        #echo ${NEW_TX[$i]}
    done
    echo ${NEW_RX[0]} ${NEW_TX[0]} ${NEW_RX[1]} ${NEW_TX[1]} 
}
net_mark=$(net_sample)

#net_calculate(){
    #
#}

#netdown(){
    #NEW_RX=$(cat /sys/class/net/${net_if_array[0]}/statistics/rx_bytes)
    #printf "%0*d" 3 $(( ($NEW_RX-$1)/1000 ))
#}
#netdown_mark=0
#
#netup(){
    #NEW_TX=$(cat /sys/class/net/enp4s0f2/statistics/tx_bytes)
    #printf "%0*d" 3 $(( ($NEW_TX-$1)/1000 ))
#}
#netup_mark=0


    # dependency: sysstat
    # mpstat 1 1 | awk '/^Average/ {print 100-$NF,"%"}'

# xsetroot -name "$(music) $(bat) • CPU $(cpu) MEM $(mem) • HDD $(hdd) \
# • EML $(eml) PKG $(pac) AUR $(ups)$(aur) • NET $(int) • $(dte) "

UTC=0   # Forces slower-updating widgets to render immedeately at start
[[ $(($UTC % 2)) -eq 0 ]] && mem=$(mem)

### MAIN EXEC
#cpu=$(cpu $cpu_mark)
# cpu_mark="$(cat /proc/stat)"
#timedate=$(timedate)
[[ $(($UTC % 2)) -eq 0 ]] && music=$(music)
bat=$(bat)
[[ $(($UTC % 30)) -eq 0 ]] && pac=$(pac)
# netdown=$(netdown $netdown_mark)
# netdown_mark=$(cat /sys/class/net/enp4s0f2/statistics/rx_bytes)
# netup=$(netup $netup_mark)
# netup_mark=$(cat /sys/class/net/enp4s0f2/statistics/tx_bytes)

# xsetroot -name "\
# $music\
# $netdown\
# $netup\
# $pac\
# $bat\
# $mem\
# $(cpu $cpu_mark)\
# $(timedate)\
# "
# UTC=$(date +%s)
# sleep 1


xsetroot -name "\
$music \
$netdown:\
$netup \
$pac \
$bat \
$mem \
$(timedate) \
"
UTC=$(date +%s)
sleep 1
