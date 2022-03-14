#!/bin/bash

url=${@: -1} # added last argument for URL

function banner() {
    echo " 

██╗  ██╗ █████╗ ██╗    ██╗██╗  ██╗███████╗██╗   ██╗███████╗    ██████╗ ███████╗ ██████╗ ██████╗ ███╗   ██╗
██║  ██║██╔══██╗██║    ██║██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗██╔════╝██╔════╝██╔═══██╗████╗  ██║
███████║███████║██║ █╗ ██║█████╔╝ █████╗   ╚████╔╝ █████╗      ██████╔╝█████╗  ██║     ██║   ██║██╔██╗ ██║
██╔══██║██╔══██║██║███╗██║██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══╝      ██╔══██╗██╔══╝  ██║     ██║   ██║██║╚██╗██║
██║  ██║██║  ██║╚███╔███╔╝██║  ██╗███████╗   ██║   ███████╗    ██║  ██║███████╗╚██████╗╚██████╔╝██║ ╚████║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                                                          

"

}



if [ $# -eq 0 ]
then
        echo "Missing options!"
        echo " "
        echo "(run ./hawkeye.sh -h for help)"
        echo " "
        exit 0
fi

ECHO="false"


# Shifted options while loop at the last
#===========================
# DIRS
#===========================
function maindir() {
    if [ ! -d "$url" ];then
	mkdir $url 
fi
}

function recondir() {
    if [ ! -d "$url/recon" ];then
	mkdir $url/recon
	fi
}

function scandirs() {
    if [ ! -d "$url/recon/scans" ];then
	mkdir $url/recon/scans
fi
}

function subdomaindir() {
    if [ ! -d "$url/recon/scans/subdomains" ];then
	mkdir $url/recon/scans/subdomains
fi
}

function nmapdir(){
    if [ ! -d "$url/recon/nmap_scan_results" ];then
    mkdir $url/recon/nmap_scan_results
fi
}

function livesubsdir1() {
    if [ ! -d '$url/recon/httprobe' ];then
    mkdir $url/recon/scans/httprobe
    fi
}

function subjackdir() {
    if [ ! -d '$url/recon/potential_sub_takeovers' ];then
    mkdir $url/recon/potential_sub_takeovers
    fi
}

function livesubfile() {
    if [ ! -f '$url/recon/scans/httprobe/alivesubs.txt' ];then
    touch $url/recon/scans/httprobe/alivesubs.txt
    fi
}

function nucleidir() {
    if [ ! -d '$url/recon/nuceli' ];then
    mkdir $url/recon/nuclei
    fi
}

function firewalldir() {
    if [ ! -d '$url/recon/wafwoof' ];then
    mkdir $url/recon/wafwoof
    fi
}

function finalsublist() {
    if [ ! -f "$url/recon/scans/subdomains/final.txt" ];then
	touch $url/recon/scans/subdomains/final.txt
fi
}

function whoisdir() {
    if [ ! -d "$url/recon/WHOISdata" ];then
    mkdir $url/recon/WHOISdata
    fi
}

function whoisfile() {
    if [ ! -f "$url/recon/WHOISdata/WHOIS.txt"];then 
    touch $url/recon/WHOISdata/WHOIS.txt
    fi
}

#======================
# COLOUR DECLARATIONS
#======================
BLUE='\033[0;34m'
CYAN='\033[0;36m'

#=======================
# TOOL INTEGRATION
#=======================

function findsubs() {
    echo -e "${BLUE}========================================================"
    echo " "
    echo  "[+] Harvesting subdomains with subfinder..."
    echo " "
    echo "[+] The subdomain list can be found in $url/recon/scans/subdomains/"
    echo " "
    echo "========================================================"
    echo " "
    subfinder -d $url > $url/recon/scans/subdomains/assets.txt
    sort -u $url/recon/scans/subdomains/assets.txt >> $url/recon/scans/subdomains/final.txt
    rm $url/recon/scans/subdomains/assets.txt
}

function pythonsubs(){
    echo -e "${BLUE}========================================================"
    echo " "
    echo "[+] Gathering subs with subby...."
    echo ""
    echo "[+] The subdomain list can be found in $url/recon/scans/subdomains/"
    echo " "
    echo "========================================================"
    echo " "
    subby.py $url > $url/recon/scans/subdomains/subs.txt
}

function livesubprobe() {
    echo -e "${BLUE}========================================================"
    echo " "
    echo "[+] Probing for alive domains using httpx..."
    echo " "
    echo "[+] The alive and responsive subdomains can be found in $url/recon/scans/httprobe/alivesubs.txt "
    echo " "
    echo "========================================================"
    echo " "
    cat $url/recon/scans/subdomains/final.txt | httpx -sc -td > $url/recon/scans/httprobe/alivesubs.txt 
}

function getwhois() {
    echo -e "${CYAN}========================================================"
    echo ""
    echo "[+] getting whois info for $url ...."
    echo " "
    echo "[+] The whois info can be found in $url/recon/WHOISdata/"
    echo " "
    echo "========================================================"
    echo ""
    whois $url > $url/recon/WHOISdata/WHOIS.txt
}

function domainflyby() {
    echo -e "${CYAN}========================================================"
    echo " " 
    echo "[+] getting screenshots and performing domain flyby with aquatone....."
    echo " "
    echo "[+] the screenshots and related data can be found in $url/recon/scans/subdomains/aquatone...."
    echo " "
    echo "========================================================"
    echo " "
    export AQUATONE_OUT_PATH="$url/recon/scans/aquatone"
    cat $url/recon/scans/httprobe/alivesubs.txt | aquatone
}

function vulnsubs() {
   echo -e "${CYAN}========================================================"
   echo " "
   echo "[+] looking for potential subdomain takeovers....."
   echo " "
   echo "[+] the result of the same can be found in $url/recon/potential_sub_takeovers/result.txt...."
   echo " "
   echo "========================================================"
   echo " "
   subjack -w $url/recon/scans/subdomains/final.txt -t 100 -timeout 30 -o $url/recon/potential_sub_takeovers/results.txt -ssl -a -v > $url/recon/potential_sub_takeovers/logs.txt
}

function firewalldetect(){
    echo -e "${CYAN}========================================================"
    echo ""
    echo "[+] detecting the web app firewall of $url...."
    echo " "
    echo "[+] the info about the web app firewall can be found in $url/recon/wafwoof"
    echo " "
    echo "========================================================"
    echo ""
    wafw00f $url > $url/recon/wafwoof/firewall.txt
}

function portscan(){
    echo -e "${CYAN}========================================================"
    echo " "
    echo "[+] scanning for open ports usnig nmap...."
    echo " "
    echo "[+] The scan results can be found in $url/recon/nmap_scan_results/open_ports.txt...."
    echo " "
    echo "========================================================"
    echo " "
    nmap -iL $url/recon/scans/subdomains/subs.txt -T5 > $url/recon/nmap_scan_results/open_ports.txt
}

function webscan(){
    echo -e "${CYAN}========================================================"
    echo " "
    echo "[+] looking for vulnerability and interesting data usnig nuceli"
    echo " "
    echo "[+] the results can be found in $url/recon/nuceli/...."
    echo " "
    echo "========================================================"
    nuclei -l $url/recon/scans/subdomains/subs.txt -t /home/user/Templates/custom_templates > $url/recon/nuclei/nuclei_logs.txt
}
#==========================
# FUNCTION CALLS
#==========================

banner


while getopts "hiwpa" OPTION; do
        case $OPTION in
	    p)                     #quickrecon- get to know your target and its assets
			maindir
            recondir
            scandirs
            subdomaindir
            livesubsdir1
            finalsublist
            livesubfile
            findsubs
            livesubprobe
            domainflyby
            exit 0 
			;;

            a) 
                maindir
                recondir
                scandirs
                subdomaindir
                livesubsdir1
                finalsublist
                livesubfile
                firewalldir
                whoisdir
                subjackdir
                getwhois
                firewalldetect
                findsubs
                pythonsubs 
                livesubprobe
                vulnsubs
                domainflyby
                nmapdir
                nucleidir             
                portscan
                webscan
                exit 0
                ;;

                w)
                 maindir
                 recondir     
                 firewalldir      
                 whoisdir
                 getwhois
                 firewalldetect
                 exit 0
                 ;;


                i)
                    maindir
                    recondir
                    scandirs    
                    subdomaindir
                    nmapdir
                    nucleidir
                    pythonsubs              
                    portscan
                    webscan
                    exit 0
                    ;;      
                 
                h)
                        echo -e "This is an automated reconnaissance tool to be used for web app pentesting \nwhich provides one with the most useful and effective data \nfor a web app vulnerability assesment or pentesting"
                        echo ""
                        echo "Usage:"
                        echo " "
                        echo  "hawkeye.sh -p target.com   --to scan target domain for quick/passive reconnaissance"
                        printf "%101s\n" "which will gether subdmoains, check for alive ones and do a domain flyby"
                        echo " "
                        echo "hawkeye.sh -i                -- to scan target domain for active reconnaissance,"
                        printf "%71s\n" "which port scan and vulnerability check"
                        echo ""
                        echo "hawkeye.sh -w target.com     --to get whois information and web app firewall data"
                        echo ""                       
                        echo "hawkeye.sh -a target.com     -- to do an in-depth scan including sub enumeration, live sub check,"
                        printf "%75s\n" "port scanning, vulnerability check and more"
                        echo " "
                        echo "hawkeye.sh   -h               --help (this output)"
                        exit 0
                        ;;      

        esac
done
