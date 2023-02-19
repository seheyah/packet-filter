#!/bin/ksh
####### pf-810ck-m41n.sh
### AUTHOR:	seheyah
### CREATION:	2020/11/14

### DATE: 2021/12/05
### UPDATE:
#		Add variable in script and increase "no-hardcode"
#		Change script name and table name
#		Move temp file to TMP folder
#		Replace pfctl command

### DATE: 2021/12/08
### UPDATE:
#		Update variable get cat wc command with awk to remove the shell format

### CONSTANT
# ARRAY
url0x00="https://www.binarydefense.com/banlist.txt https://rules.emergingthreats.net/blockrules/compromised-ips.txt https://iplists.firehol.org/files/firehol_level1.netset https://iplists.firehol.org/files/firehol_level2.netset https://feodotracker.abuse.ch/downloads/ipblocklist.txt http://blocklist.greensnow.co/greensnow.txt https://sslbl.abuse.ch/blacklist/sslipblacklist.txt https://www.team-cymru.org/Services/Bogons/fullbogons-ipv4.txt https://www.spamhaus.org/drop/drop.txt https://www.spamhaus.org/drop/edrop.txt"

# FILE
filexall="/etc/pf-tables/pf-810ck-m41n.pft"
filextmp="/tmp/0.txt"
filextpm="/tmp/x.txt"
filexend="/tmp/1.txt"
filexpft="/tmp/pf-810ck-m41n.pft"

# STRING
str0x00="pf-810ck-m41n"
str0x01="2021/12/05"
str0x02="Falken"
str0x03="0xff"

### VARIABLE
# INTEGER
i42=0

##### MAIN
echo "+-------------------------------------------------------------------------------------------"
echo "| 0-0-0- |-> $str0x00\n|\n|\t Service: PF\n|\t Action: Update $str0x00 table\n|"
echo "|\t Version: $str0x03\n|\t Release date: $str0x02\n|\t Release name: $str0x01"
echo "|-------------------------------------------------------------------------------------------"
printf "|%-30s|%-25s|%-10s|%-10s|%-10s|%-s\n" " Provider" " File" "  Status" " Raw data" " Real Data ";
echo "|-------------------------------------------------------------------------------------------"

# Looping with FTP and prepare file
for uri in $url0x00; do
	i42=$(( i42 + 1 ))
	str0x04="$(echo "$uri" | sed -e 's|^[^/]*//||' -e 's|/.*$||')"
	str0x05="$(basename $uri)"
	ftp -4 -o $filextmp $uri > /dev/null 
	if [ ! -f $filextmp ]; then
		printf "|%-30s|%-25s|%-10s|%-10s|%-10s|%-s\n" " $str0x04" " $str0x05" "  Failed " " 0 " " 0 ";
	else

		a="$(cat $filextmp | wc -l)"
		if (( i42 < 9 )); then
			sed -i 's/^M//g' $filextmp
			sed -i '/^#/d' $filextmp
			sed -i '/^$/d' $filextmp
			cat $filextmp >> $filexend
			b="$(cat $filextmp | wc -l | awk '{ print $1 }')"
		else
			sed -i '1,4d' $filextmp
			cat $filextmp | awk '{print $1 }' | sed 's/ //g' >> $filexend
			b="$(cat $filextmp | wc -l | awk '{ print $1 }')"
		fi
		printf "|%-30s|%-25s|%-10s|%-10s|%-10s|%-s\n" " $str0x04" " $str0x05" "  Success " " $a " " $b  ";	
	fi
	
	if [ -f $filextmp ]; then
		rm $filextmp
	fi
done

echo "|-------------------------------------------------------------------------------------------"

if (( i42 > 0 )); then
	echo "|\n| Build tablename $str0x00:"
        c="$(cat $filexend | wc -l | awk '{ print $1 }')"
        echo "|\t Total of download entries: $c"
       	cat $filexend | sort -du > $filexpft
       	d="$(cat $filexpft | wc -l | awk '{ print $1 }')"
        echo "|\t Total of cleaning entries: $d"
	e="$(cat $filexall | wc -l | awk '{ print $1 }')"
	echo "|\t Total of previous entries: $e"
fi

echo "|-------------------------------------------------------------------------------------------"
echo "|\n| 0-0-0- |-> Reload PF Service"
mv $filexpft $filexall
pfctl -t $str0x00 -T replace -f $filexall > /dev/null 2>&1

if [ ! -f $filexend ]; then
	i42=0
	echo "|\n| 0-0-0- |-> Clean workspace: done \n|"
else
	rm $filexend
	i42=0
	echo "|\n| 0-0-0- |-> Clean workspace: done\n|"
fi
echo "|-------------------------------------------------------------------------------------------"
echo "| exit 0"
echo "|-------------------------------------------------------------------------------------------"
exit 0

####### END
