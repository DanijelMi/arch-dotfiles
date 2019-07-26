#!/usr/bin/env bash
# Author: Danijel Milosevic
# Status bar primarily made for dwm

cpu(){
    read cpu a b c previdle rest <<< $(echo "$1 $2 $3 $4 $5")
    prevtotal=$((a+b+c+previdle))
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu="$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))"
    printf "C%0*d" 2 $cpu
}
cpu_mark="$(cat /proc/stat)"

#TODO: SHORTEN
mem(){
    ram=$(free | grep Mem: | awk {'printf("%.0f", $3/$2 * 100.0)}')
    printf "M%0*d" 2 $ram
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
        echo -e "-$charge"
    elif [[ ( -z $onl && $charge -le 20 ) ]]; then
        echo -e "-$charge!"
    else
        echo -e "+$charge"
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

# Takes a sample of bytes transmitted and recieved since the boot time for each active interface
net_sample(){
    NEW_RX=()   # DOWNLOAD
    for i in "${!net_if_array[@]}"; do
        NEW_RX[$i]=$(cat /sys/class/net/${net_if_array[$i]}/statistics/rx_bytes)
    done
    NEW_TX=()   # UPLOAD
    for i in "${!net_if_array[@]}"; do
        NEW_TX[$i]=$(cat /sys/class/net/${net_if_array[$i]}/statistics/tx_bytes)
    done
    echo ${NEW_RX[0]} ${NEW_TX[0]} ${NEW_RX[1]} ${NEW_TX[1]} 
}
net_mark=(0 0 0 0 0 0 0 0)  # Exists only so that the first math operations aren't invalid

# Calculates and nicely formats the byte delta from the last taken sample (passed as array arg) and new net_sample
net_calculate(){
    fn_args=("$@")
    net_mark=($(net_sample))
    output=""
    for i in "${!net_mark[@]}"; do
        if [ $(($i % 2)) -eq 0 ]; then
            output+=" ${net_if_array[ $(( $i/2 )) ]}-"
            output+=$( printf "%0*d\n" 3 $(( (${net_mark[$i]} - ${fn_args[$i]}) / ($(date +%s) - $UTC) / 1000 )) ):
        else
            output+=$( printf "%0*d\n" 3 $(( (${net_mark[$i]} - ${fn_args[$i]}) / ($(date +%s) - $UTC) / 1000 )) )
        fi
    done
    echo $output
}

UTC=0   # Forces widgets to render immedeately from start
while true; do
    # Builds a list of active network interfaces
    [[ $(($UTC % 5)) -eq 0 ]] && net_if_array=($(ip -o -4 route show to default | awk '{print $5}'))
    net=$(net_calculate ${net_mark[@]}) # Network bandwidth
    net_mark=($(net_sample))    # Obligatory byte snapshot for the next network delta calculation
    cpu=$(cpu $cpu_mark)
    cpu_mark="$(cat /proc/stat)"    # Obligatory cpu usage snapshot for the next cpu delta calculation
    bat=$(bat)                  # Battery
    [[ $(($UTC % 2)) -eq 0 ]] && mem=$(mem) # Memory
    [[ $(($UTC % 2)) -eq 0 ]] && music=$(music) # MPD data
    [[ $(($UTC % 30)) -eq 0 ]] && pac=$(pac)    # Pacman available updates

# Indentation would add whitespace to output
    xsetroot -name "\
$pac \
$music \
$net \
$cpu \
$bat \
$mem \
$(date "+%H:%M")\
"
    UTC=$(date +%s)
    sleep 1
done