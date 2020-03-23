#!/usr/bin/env bash
# 'sox' package needed for boops
#sleep_time=1
printf '\nChange interval: +-*/   Invert boop condition: i   Disable boop: b\n\n'
boop_condition=0     # Flag setting if boop on succesful(0) ping or failed(1) ping
boop_on=1            # Flag if boop should work at all (1 means yes)

while :; do 
  if [ -z $sleep_time ]; then sleep_time=1 
  else read -t $sleep_time -rsn1 input ; fi
  if [ "$input" = "+" ]; then
    delta=1
  elif [ "$input" = "-" ] && (( $(echo "$sleep_time >= 1.2" | bc -l) )); then
    delta=-1
  elif [ "$input" = "*" ] && (( $(echo "$sleep_time < 1000000" | bc -l) )); then
    delta=$sleep_time
  elif [ "$input" = "/" ]; then
    delta=$(($sleep_time / -2))
  elif [ "$input" = "i" ]; then
    boop_condition=$((1-$boop_condition))
    if [[ $boop_condition -eq 0 ]]; then printf "\nBeep on successful pings\n\n"
    elif [[ $boop_condition -eq 1 ]]; then printf "\nBeep on failed pings\n\n"; fi
    delta=0
    continue
  elif [ "$input" = "b" ]; then
    boop_on=$((1-$boop_on))
    if [[ $boop_on -eq 0 ]]; then printf "\nBeep turned OFF\n\n"
    elif [[ $boop_on -eq 1 ]]; then printf "\nBeep turned ON\n\n"; fi
    delta=0
    continue
  else
    ipcheck=$(ping -c 1 1.1.1.1)
    test $? == 0
    ipcheck_success=$?
    if [[ $ipcheck_success -eq $boop_condition ]] && [[ boop_on -eq 1 ]]; then play -V -r 48000 -n synth 0.02 sin 1000 vol 1dB >/dev/null 2>&1 ; fi
    echo -e "$ipcheck" | head -n 2 | tail -n 1
    if [[ $ipcheck_success -eq 0 ]]; then
      dnscheck=$(ping -c 1 www.google.com )
      test $? == 0
      dnscheck_success=$?
      if [[ $dnscheck_success -eq $boop_condition ]] && [[ boop_on -eq 1 ]]; then play -V -r 48000 -n synth 0.02 sin 500 vol 1dB >/dev/null 2>&1 ; fi
      echo -e "$dnscheck" | head -n 2 | tail -n 1
    fi
    continue
  fi
  sleep_time=$(echo $sleep_time + $delta | bc)
  echo "Interval: $sleep_time seconds"
done
