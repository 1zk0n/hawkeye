#!/bin/bash

function subfinder() {
	echo "Installing subfinder..."
	go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
}

function subby(){
	echo "Installing subby...."
	git clone https://github.com/1zk0n/subby
	export PATH=$PATH:/home/user/subby
}

function wafw00f(){
	echo "Installing wafw00f...."
	git clone https://github.com/EnableSecurity/wafw00f
	python setup.py install
}

function httpx(){
	echo "Installing httpx..."
	go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
}

function subjack(){
	echo "Installing subjack...."
	go get github.com/haccer/subjack
}

function aquatone (){
	echo "Installing aquatone....."
	mkdir aquatone
	cd aquatone
	wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
	unzip aquatone_linux_amd64_1.7.0.zip
	export PATH=$PATH:/home/user/aquatone #might need changing depending on install location
}

function nuclei (){
	echo "Installing nuclei..."
	go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
}

subfinder
subby
subjack
httpx
aquatone
nuclei