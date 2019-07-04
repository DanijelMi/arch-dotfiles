#!/usr/bin/env bash
# Status script for dwm
# colours: 01:normal 02:white 03:red 04:green 05:yellow 06:blue
# 07:cyan 08:magenta 09:grey

music(){
    track="$(mpc current)"
    artist="${track%%- *}"
    title="${track##*- }"
    [[ -n "$artist" ]] && echo -e "$artist $title •"
}

bat(){
    onl="$(grep "on-line" <(acpi -V))"
    charge="$(awk '{print +$4}' <(acpi -b))"
    if [[ ( -z $onl && $charge -gt 20 ) ]]; then
        echo -e "BAT $charge%"
    elif [[ ( -z $onl && $charge -le 20 ) ]]; then
        echo -e "BAT $charge%"
    else
        echo -e "AC $charge%"
    fi
}

mem(){
    echo -e "$(free -m | grep Mem: | awk {'print ($3/$2)'})"
}

# CPU line courtesy Procyon:
# https://bbs.archlinux.org/viewtopic.php?pid=874333#p874333
cpu(){
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu="$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))"
    echo -e "\x05$cpu%\x01"
}

hdd(){
    hd=( $(awk '
        {i=$5} /boot/ {a=i}; /root/ {b=i}; /home/ {c=i}; /media/ {d=i}
        END {if (NR==10) print a,b,c,d; else print a,b,c}
               ' <(df -P)) )
    drives="${#hd[@]}"
    if [[ "$drives" -eq 3 ]]; then
        echo -e "\x08${hd[@]}\x01"
    else
        echo -e "\x08${hd[@]:0:3} \x06${hd[@]:3:1}\x01"
    fi
}

eml(){
    maildirs="$HOME/Mail/*/INBOX/new/"
    ml="$(find $maildirs -type f | wc -l)"
    if [[ $ml -eq 0 ]]; then
        echo "0"
    else
        echo -en "\x03$ml\x01"
    fi
}

pac(){
    pup="$(pacman -Qqu --dbpath /tmp/checkup-db-jason/ | wc -l)"
    if [[ $pup -eq 0 ]]; then
        echo "0"
    else
        echo -en "\x05$pup\x01"
    fi
}

ups(){
    ups="$(awk '$0 !~ /tamsyn/' /tmp/aurupdates* | wc -l)"
    if [[ $ups -eq 0 ]]; then
        echo "0"
    else echo -en "\x05$ups\x01"
    fi
}

aur(){
     aur="$(awk '$0 !~ /^No /' /tmp/aurphans* | wc -l)"
     if [[ $aur -gt 0 ]]; then
        echo -en "\x03 ∆\x01"
     fi
}

int(){
    host google.com>/dev/null &&
    echo -e "\x06ON\x01" || echo -e "\x03NO\x01"
}

dte(){
    dte="$(date "+%I:%M")"
    echo -e "\x02$dte\x01"
}

# Pipe to status bar
# xsetroot -name "$(music) $(bat) • CPU $(cpu) MEM $(mem) • HDD $(hdd) \
# • EML $(eml) PKG $(pac) AUR $(ups)$(aur) • NET $(int) • $(dte) "
xsetroot -name "$(music) $(bat) $(mem)"