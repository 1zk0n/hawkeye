# Hawkeye
Hawkeye is a recon automation tool that can help a lot in bug bounty huting. I created this tool basically to automate my recon methodology which i have been using for a while now. It takes off the stress of using each tool individually and storing and sorting all of the outputs. This tool takes care of all that for me by making separate directories for each target bearing the target name 

# Features
It can do: 
 - subdomain enumeration 
 - duplicate subdomain filtering
 - get whois information
 - check web app firewall
 - checking for alive subs and checking the technology they're running 
 - checking for subdomain takeover
 - subdomain flyby
 - port scanning 
 - use nuclei and its templates (customizable)
 - print out the output location of the scans
 
 # Requirements 
 Should have go and python installed, preferably run on linux
 
 # Usage
 Hawkeye comes with a bunch of options from quick recon to in-depth scanning 
 
 ```hawkeye.sh -p``` this is for quick recon i.e. it scans for subs, checks for alive ones, and does domain flyby. This gets you enough information to get started on a target for bug bounty hunting. This scan usually takes around 7-10 minutes to complete
 
 ```hawkeye.sh -h``` to toggle help screen
 
 ```hawkeye.sh -w``` this option gives you the whois and web app firewall info about the target
 
 ```hawkeye.sh -a``` this is the in-depth option which performs all the things mentioned in the features section
 
 ```hawkeye.sh -e``` this option does port scanning and uses nuclei to check for vulnerabilities
 
 
