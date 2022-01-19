#!/bin/bash

#-------------------------------------------------------------------------------------------
# A script to automatically download Sentinel-1 SLC from Copernicus server using dhushget.                                                  	
#-------------------------------------------------------------------------------------------
export VERSION=0.1
export DHUS_DEST="https://scihub.copernicus.eu/gnss/"
export USERNAME="gnssguest"
export PASSWORD="gnssguest"
bold=$(tput bold)
normal=$(tput sgr0)
print_script=`echo "$0" | rev | cut -d'/' -f1 | rev`
function print_usage 
{ 
 print_script=`echo "$1" | rev | cut -d'/' -f1 | rev`
 echo " "
 echo "${bold}USAGE${normal}"
 echo " "
 echo "  $print_script -F /path/to/slc/folder "
 echo " "
 echo "${bold}DESCRIPTION${normal}"
 echo " "
 echo "  This script allows to get Precise Orbit Files (POEORB) for Sentinel-1 from Copernicus Data Hub."
 echo " "
 echo "${bold}REQUIREMENTS${normal}"
 echo " "
 echo " 1. DHuSget - The non interactive Sentinels product retriever from the Sentinels Data Hubs"
 echo " 2. Wget: https://www.gnu.org/software/wget/"
 echo " 3. search_dates.py: Auxiliary python script to calculate dates for dhusget query."
 echo " "
 exit -1
}

function downloader
{
 cd $FOLDER
 rm -f temp
 rm -f tempQuery
 for f in S1?_IW_SLC*zip
 do
    echo $f >> temp
 done
 python search_dates.py $FOLDER
 input="$FOLDER/tempQuery"
 while IFS= read -r line
 do
	dhusget.sh -d $DHUS_DEST -u $USERNAME -p $PASSWORD -F $line
	productUID=$(awk '{ if(NR==1) print $2 }' product_list)
	wget --content-disposition --continue --user=$USERNAME --password=$PASSWORD "https://scihub.copernicus.eu/gnss/odata/v1/Products('$productUID')/\$value"	
 done < "$input"
 rm -f failed_MD5_check_list.txt
 rm -r logs
 rm -f OSquery-result.xml
 rm -f product_list
 rm -f products-list.csv
 rm -f temp
 rm -f tempQuery
}

while getopts ":h:F:" opt; do
 case $opt in
    	h)	
		print_usage $0
		;;
	    F)
		export FOLDER="$OPTARG"
        downloader
		;;
    esac
done
echo ""
echo "================================================================================================================" 
echo ""
echo "Type '$print_script -help' for usage information"
echo ""
echo "================================================================================================================"

