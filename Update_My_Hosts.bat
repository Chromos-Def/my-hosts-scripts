@echo off

echo Downloading updates.....please standby
powershell -Command "Invoke-WebRequest https://mirror.cedia.org.ec/malwaredomains/domains.hosts -OutFile CEDIA_Domains.txt"
powershell -Command "Invoke-WebRequest https://mirror.cedia.org.ec/malwaredomains/immortal_domains.txt -OutFile RAW_CEDIA_Immortal_Domains.txt"
powershell -Command "Invoke-WebRequest https://someonewhocares.org/hosts/zero/hosts -OutFile Dan_Pollock.txt"
powershell -Command "Invoke-WebRequest https://www.malwaredomainlist.com/hostslist/hosts.txt -OutFile Malware_Domain_List.txt"
powershell -Command "Invoke-WebRequest https://winhelp2002.mvps.org/hosts.txt -OutFile MVPS.txt"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt -OutFile NoCoin.txt"
powershell -Command "Invoke-WebRequest https://pgl.yoyo.org/adservers/serverlist.php?showintro=0 -OutFile RAW_Peter_Lowe.txt"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Chromos-Def/my-hosts-scripts/master/Persistent/Block-Redshell-Hosts.txt -OutFile Block-Redshell-Hosts.txt"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Chromos-Def/my-hosts-scripts/master/Persistent/MyCustomHosts.txt -OutFile MyCustomHosts.txt"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Chromos-Def/my-hosts-scripts/master/Persistent/RW_DOMBL.txt -OutFile RW_DOMBL.txt"
echo.
echo Updates are done downloading

REM The following line copies only lines containing 127.0.0.1 to the new file
sed -n "/127.0.0.1/p" RAW_Peter_Lowe.txt > Peter_Lowe.txt
del RAW_Peter_Lowe.txt

REM The folling line will remove line #1 from the following text file
sed "1d" RAW_CEDIA_Immortal_Domains.txt > Line_1_Removed_CEDIA_Immortal_Domains.txt
del RAW_CEDIA_Immortal_Domains.txt

REM The following line adds "0.0.0.0  " to the beginning of each line to the new file
sed "s/^/0.0.0.0 /" Line_1_Removed_CEDIA_Immortal_Domains.txt > CEDIA_Immortal_Domains.txt
del Line_1_Removed_CEDIA_Immortal_Domains.txt

echo.

REM Merges all .txt files into ALL_HOSTS.txt
echo Merging all .txt files into a single file
echo.
copy *.txt ALL_HOSTS.txt
echo.
echo All .txt files successfully merged

REM Removes comments
sed "s/#.*$//;/^$/d" ALL_HOSTS.txt > Comments_removed_HOSTS.txt

REM Replaces all instances of 127.0.0.1 with 0.0.0.0
sed "s+127.0.0.1+0.0.0.0+g" Comments_removed_HOSTS.txt > IPs_replaced_HOSTS.txt

REM Removes blank spaces at the end of lines
sed "s/[[:space:]]*$//" IPs_replaced_HOSTS.txt > End_blanks_gone_HOSTS.txt

REM Deletes duplicate lines
awk "!x[$0]++" End_blanks_gone_HOSTS.txt > Duplicates_removed_HOSTS.txt

REM Removes whitespace/indentations
sed "s/^[ \t]*//" Duplicates_removed_HOSTS.txt > Whitespace_removed_HOSTS.txt

REM Removes any remaing blank lines
sed "/^$/d" Whitespace_removed_HOSTS.txt > HOSTS

echo.
echo Done

REM Clean up of unused .txt files
del ALL_HOSTS.txt
del Comments_removed_HOSTS.txt
del IPs_replaced_HOSTS.txt
del End_blanks_gone_HOSTS.txt
del Duplicates_removed_HOSTS.txt
del Whitespace_removed_HOSTS.txt
del CEDIA_Domains.txt
del CEDIA_Immortal_Domains.txt
del Dan_Pollock.txt
del Malware_Domain_List.txt
del MVPS.txt
del NoCoin.txt
del Peter_Lowe.txt
del Block-Redshell-Hosts.txt
del MyCustomHosts.txt
del RW_DOMBL.txt

echo.

pause