#!/bin/ksh
####### pf-53cu217y-2314y.sh
### AUTHOR:	seheyah
### CREATION:	2023/07/15

### DATE: yyyy/mm/dd
### UPDATE:
#               xxxxxxxxx

### CONSTANT
# ARRAY

# FILE
filexall="/j05hu4/748l3/pf-53cu217y-3x724.pft"
filextmp00="/j05hu4/tmp/0.txt"
filextmp01="/j05hu4/tmp/1.txt"
filexpft="/j05hu4/tmp/pf-53cu217y-3x724.pft"

# STRING
str0x00="pf-53cu217y-3x724"
str0x01="2023/07/15"
str0x02=""Alfred
str0x03="1.0.0"

### VARIABLE
# INTEGER

##### MAIN
echo "+-------------------------------------------------------------------------------------------"
echo "| j05hu4 |-> $str0x00\n|\n|\t Service: PF\n|\t Action: Update $str0x00 table\n|"
echo "|\t Version: $str0x03\n|\t Release date: $str0x02\n|\t Release name: $str0x01"
echo "|-------------------------------------------------------------------------------------------"

if [ -f $filextmp00 ]; then
	rm $filextmp00
fi

if [ -f $filextmp01 ]; then
	rm $filextmp01
fi

pfctl -t $str0x00 -T show | awk '{ print $1 }' | sort -du >> $filextmp00
cat /var/log/messages | grep "relayd" | awk '{ print $13 }' | sort -du >> $filextmp01
cat $filextmp00 $filextmp01 | sort -du >> $filexpft

echo "|\n| Build tablename $str0x00:"
a="$(cat $filextmp01 | wc -l | awk '{ print $1 }')"
echo "|\t Total of entries in log: $a"
b="$(cat $filexpft | wc -l | awk '{ print $1 }')"
echo "|\t Total of entries now in $str0x00: $b"
c="$(cat $filextmp00 | wc -l | awk '{ print $1 }')"
echo "|\t Total of entries before in $stxr0x00: $c\n|"

echo "|-------------------------------------------------------------------------------------------"
mv $filexpft $filexall
pfctl -t $str0x00 -T replace -f $filexall > /dev/null 2>&1
echo "|\n| j05hu4 |-> Reload PF Service: done"
rm $filextmp00
rm $filextmp01
echo "| j05hu4 |-> Clean workspace: done\n|"
echo "|-------------------------------------------------------------------------------------------"
echo "| exit 0"
echo "|-------------------------------------------------------------------------------------------"
exit 0

####### END
