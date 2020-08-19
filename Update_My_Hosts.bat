@echo off

echo Downloading updates.....please standby
powershell -Command "Invoke-WebRequest https://mirror.cedia.org.ec/malwaredomains/domains.hosts -OutFile CEDIA_Domains.txt"
powershell -Command "Invoke-WebRequest https://mirror.cedia.org.ec/malwaredomains/immortal_domains.txt -OutFile RAW_CEDIA_Immortal_Domains.txt"
powershell -Command "Invoke-WebRequest https://someonewhocares.org/hosts/zero/hosts -OutFile Dan_Pollock.txt"
powershell -Command "Invoke-WebRequest https://www.malwaredomainlist.com/hostslist/hosts.txt -OutFile Malware_Domain_List.txt"
powershell -Command "Invoke-WebRequest https://winhelp2002.mvps.org/hosts.txt -OutFile MVPS.txt"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt -OutFile NoCoin.txt"
powershell -Command "Invoke-WebRequest https://pgl.yoyo.org/adservers/serverlist.php?showintro=0 -OutFile RAW_Peter_Lowe.txt"
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
REM Combines all host .txt files and then outputs them into HOSTS
echo Combining all host .txt files
echo.
copy *.txt HOSTS
echo.
echo All files successfully copied to HOSTS

REM Cleaning up unused .txt files
del CEDIA_Domains.txt
del CEDIA_Immortal_Domains.txt
del Dan_Pollock.txt
del Malware_Domain_List.txt
del MVPS.txt
del NoCoin.txt
del Peter_Lowe.txt

echo.

pause