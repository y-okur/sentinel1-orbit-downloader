# Automatic Orbit File (Precise Orbit Files, POEORB) Downloader for Sentinel-1

Yağızalp OKUR | yagizalp.okur@dc.tohoku.ac.jp

This is a simple bash script to download an orbit file from Copernicus Data Hub.

## Requirements

1. Python3
2. wget: https://www.gnu.org/software/wget/
3. dhusget: https://scihub.copernicus.eu/twiki/do/view/SciHubUserGuide/BatchScripting#dhusget_script

## Installation

1. Make sure you have Python3 and wget
2. Download dhusget from Copernicus Open Access Hub and copy it somewhere in your system (recommended /usr/local/bin)
3. Download fetch_orbit.sh and search_date.py and copy it somewhere in your system (recommended /usr/local/bin)
4. Give execution permission to downloaded files

## Usage

run ```fetch_orbit.sh -F /path/to/slc/folder``` to download orbit files.
The script finds all SLC files in the input folder and downloads orbit files to the same folder.
You can use it to download single or multiple files.

## Version History

v 0.1 - Initial release - Jan 19, 2022
