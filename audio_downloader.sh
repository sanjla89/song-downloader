#!/bin/bash

#color define
red="\e[1;31m"
green="\e[1;32m"
blue="\e[1;34m"
reset="\e[0m"

#check if yt-dlp exist or not 
if ! command -v yt-dlp &>/dev/null; then
	echo "yt-dlp installing"
	pkg install yt-dlp -y
fi


download_audio(){
echo -e "${blue}Select downloading path${reset}"
#take audio downloading path
printf "${red}[1]==> ${reset}${blue}/sdcard/romantic_music/${reset}\n"
printf "${red}[2]==> ${reset}${blue}/sdcard/lofi_music/${reset}\n"
printf "${red}[3]==> ${reset}${blue}/sdcard/remix_music/${reset}\n"
printf "${red}[4]==> ${reset}${blue}/sdcard/cool_music/${reset}\n"
printf "${red}[5]==> ${reset}${blue}/sdcard/attitude_music/${reset}\n"
printf "${red}[6]==> ${reset}${blue}custom downloading path${reset}\n"
echo -e "${red}"
echo -e "Choise example(1, 2, 3, etc.)"
read -p "Select choice : " choice
echo -e "${reset}"
#check is user input an empty
if [[ -z "$choice" ]]; then
	downloading_path="$default_download_path"
elif [[ "$choice" -eq 1 ]]; then
		downloading_path="/sdcard/romantic_music/"
elif [[ "$choice" -eq 2 ]]; then
		downloading_path="/sdcard/lofi_music/"
elif [[ "$choice"  -eq 3 ]]; then
	downloading_path="/sdcard/remix_music/"
elif [[ "$choice" -eq  4 ]]; then
	downloading_path="/sdcard/cool_music/"
elif [[ "$choice" -eq 5 ]]; then
	downloading_path="/sdcard/attitude_music/"
elif [[ "$choice" -eq 6 ]]; then
	printf "${green}Enter custom downloading path : ${reset}\n"
	read path 
	downloading_path="$path"
fi

mkdir -p "$downloading_path"

audio_quality=128k
printf "${green}Please wait..\n"
yt-dlp -f "bestaudio[ext=m4a]" \
		"$url" \
		--extract-audio \
		--audio-format mp3 \
		--audio-quality "$audio_quality" \
		-o "$downloading_path%(title)s.%(ext)s"
printf "${green}Download completed${reset}\n"
}
#download path 
default_download_path="/sdcard/Downloads/"
downloading_path=""
#take video url input
read -p "Enter audio url : " url


#check if url are empty
if [[ -z "$url" ]]; then
	exit 1
else
	download_audio
fi


