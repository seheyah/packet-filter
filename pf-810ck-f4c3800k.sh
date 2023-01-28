#!/bin/ksh
####### pf-810ck-f4c3800k.sh
### AUTHOR:     seheyah
### CREATION:   2022/05/09

### DATE: 2022/05/09
### UPDATE:
#               Add variable for filexwww
#               Add cp command for website

### CONSTANT
# ARRAY

# FILE
filerun01="/etc/pf-tables/pf-810ck-f4c3800k.pft"
filetmp01="/tmp/0.txt"
filetmp02="/tmp/pf-810ck-f4c3800k.pft"

# STRING
str0x00="pf-810ck-f4c3800k"
str0x01="2022/05/09"
str0x02="Falken"
str0x03="1.0a"

### VARIABLE
# INTEGER

##### MAIN
echo "|-------------------------------------------------------------------------------------------"
echo "| 0-0-0- |-> $str0x00\n|\n|\t Service: PF\n|\t Action: Update $str0x00 table\n|"
echo "|\t Version: $str0x03\n|\t Release date: $str0x02\n|\t Release name: $str0x01"
echo "|-------------------------------------------------------------------------------------------"

whois -h whois.radb.net -- '-i origin AS32934' | grep ^route >> $filetmp01
cat $filetmp01 | awk '{ print $2 }' >> $filetmp02
a="$(cat $filetmp02 | wc -l)"
b="$(cat $filerun01 | wc -l | awk '{ print $1 }')"

echo "|\n|\t Total of previous entries: $b"
echo "|\t Total of new entries: $a\n|"

echo "|-------------------------------------------------------------------------------------------"
echo "|\n| 0-0-0- |-> Table $str0x00 update in progress"
mv $filetmp02 $filerun01

pfctl -t $str0x00 -T replace -f $filerun01 > /dev/null 2>&1

echo "| 0-0-0- |-> Table $str0x00 updated\n|"

rm -f $filetmp01
rm -f $filetmp02

echo "|-------------------------------------------------------------------------------------------"
echo "|\n| 0-0-0- |-> Clean workspace: done\n|"
echo "|-------------------------------------------------------------------------------------------"
echo "| exit 0"
echo "|-------------------------------------------------------------------------------------------"
exit 0

####### END
