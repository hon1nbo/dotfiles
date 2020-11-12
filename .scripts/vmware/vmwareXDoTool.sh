#!/bin/bash

###########################
# File: dotfiles/.scripts/vmware/vmwareXDoTool.sh
# Script Group: Core Scripts
# Platform: Multi (Arch, Debian, CentOS-RHEL)
# Description:
# Acts as a buffer between a calling application and XDoTool
# certain programs like VMWare are pulling under the hood shenanigans as part of their hotkeys.
# When using 'xdotool type Sample1@' into a VMWare Guest (such as KeePass autotype and various automation)
# VMWare will not honour the characters as sent, rather they must be sent with a hard shift keycode
# The result was the guest OS receiving 'sample12'
# This is strange, given that when using xev or similar it shows the implied shift as a separate entry
# This script parses the input to XDoTool and re-writes it using explicit shift characters
# Usage: ./vmwareXDoTool.sh <string>
# KeePass Usage (in AutoType Field): {CMD:!/absolute/path/to/vmwareXDoTool.sh {PASSWORD}!W=1,WS=H}
# Operational Notes:
# Made on the fly for a typical US keyboard. Bleh.
# Does not currently support ' and " characters. Need to debug how to avoid escaping in the password field when using the CMD placeholder.
# I wrote this in a pinch so will deal with that later
#############################

origStr=$1

declare -i length
length=${#origStr} # get the length of the autotype

#echo "OriginalString Length: $length"

# KeePass doesn't seem to support the DELAY placeholder in conjunction with the CMD one
# so we delay here

sleep 3

for (( i=0; i<$length; i++ ))
do
    tempChar=${origStr:i:1}
    case "$tempChar" in
        A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z)
            xdotool key shift+$tempChar
        ;;
        '!')
            xdotool key shift+1
        ;;
       	'@')
       	    xdotool key shift+2
       	;;
       	'#')
       	    xdotool key shift+3
       	;;
       	'$')
       	    xdotool key shift+4
       	;;
       	'%')
       	    xdotool key shift+5
       	;;
       	'^')
       	    xdotool key shift+6
       	;;
       	'&')
       	    xdotool key shift+7
       	;;
       	'*')
       	    xdotool key shift+8
       	;;
       	'(')
       	    xdotool key shift+9
       	;;
       	')')
       	    xdotool key shift+0
       	;;
        '-')
            xdotool key minus
        ;;
       	'_')
       	    xdotool key shift+minus
       	;;
        '=')
            xdotool key equal
        ;;
       	'+')
       	    xdotool key shift+equal
       	;;
        '[')
            xdotool key bracketleft
        ;;
       	'{')
       	    xdotool key shift+bracketleft
       	;;
        ']')
            xdotool key bracketright
        ;;
       	'}')
       	    xdotool key shift+bracketright
       	;;
       	'|')
       	    xdotool key shift+backslash
       	;;
        ';')
            xdotool key semicolon
        ;;
       	':')
       	    xdotool key shift+semicolon
       	;;
       	'"')
       	    xdotool key shift+apostrophe
       	;;
       	'<')
       	    xdotool key shift+comma
       	;;
       	'>')
       	    xdotool key shift+period
       	;;
       	'?')
       	    xdotool key shift+slash
       	;;
        '`')
            xdotool key grave
        ;;
       	'~')
       	    xdotool key shift+grave
       	;;
       '/')
            xdotool key slash
        ;;
        ',')
            xdotool key comma
        ;;
        '.')
            xdotool key period
        ;;
        *)
            xdotool key $tempChar
        ;;
    esac

    #tmpStr+=$tempChar
done

#echo $tmpStr
#sleep 1 && xdotool type $tmpStr

