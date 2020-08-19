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

REM The following line copies only lines containing 127.0.0.1 to the new file.
sed -n "/127.0.0.1/p" RAW_Peter_Lowe.txt > Peter_Lowe.txt
del RAW_Peter_Lowe.txt

REM The folling line will remove line #1 from the following text file.
sed "1d" RAW_CEDIA_Immortal_Domains.txt > Line_1_Removed_CEDIA_Immortal_Domains.txt
del RAW_CEDIA_Immortal_Domains.txt

REM The following line adds "0.0.0.0  " to the beginning of each line to the new file.
sed "s/^/0.0.0.0 /" Line_1_Removed_CEDIA_Immortal_Domains.txt > CEDIA_Immortal_Domains.txt
del Line_1_Removed_CEDIA_Immortal_Domains.txt

echo.
REM Combines all host .txt files and then outputs them into HOSTS.txt
echo Combining all host .txt files into a single file named HOSTS.txt
echo.
copy *.txt HOSTS.txt
echo.
echo All files successfully copied to HOSTS.txt
echo.
echo Replacing all instances of 127.0.0.1 with 0.0.0.0
sed -e "s/127.0.0.1/0.0.0.0/g" HOSTS.txt > HOSTS
echo.
echo Done

REM Cleaning up unused .txt files
del HOSTS.txt
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