#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from datetime import datetime
from dateutil.relativedelta import relativedelta
import argparse
from argparse import RawTextHelpFormatter

def search_dates(folder):
    pathToFile = folder+"/temp"
    with open(pathToFile, 'r') as f:
        data = f.read()
        data = list(data.split("\n"))
        data = data[:-1]
        query = []
        for each in data:
            out = each.split("_")
            satellite = out[0]
            year = out[5][0:4]
            month = out[5][4:6]
            day = out[5][6:8]
            ts = datetime(int(year),int(month),int(day))
            oneDayAfter = ts + relativedelta(days=1)
            oneDayBefore = ts - relativedelta(days=1)
            query.append('filename:'+satellite+'_OPER_AUX_POEORB_OPOD_????????T??????_V'+oneDayBefore.strftime('%Y')+oneDayBefore.strftime('%m')+oneDayBefore.strftime('%d')\
                         +'T??????_'+oneDayAfter.strftime('%Y')+oneDayAfter.strftime('%m')+oneDayAfter.strftime('%d')+"*")
    return query

def write_file(query):
    textfile = open("tempQuery","w")
    for each in query:
        textfile.write(each + "\n")
    textfile.close()
    

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='''
    --------
    Overview
    --------
    This script is used to get query dates for fetch_orbit.sh
    It writes search query for each SLC file in the input directory to a file called tempQuery
    which fetch_orbit.sh script uses to download orbit files.
    -----
    Usage
    -----
    search_dates.py path/to/slc/folder
    ---------
    ChangeLog
    ---------
    19 Jan. 2022: Initial creation by Yagizalp OKUR, Tohoku  University''',
    formatter_class=RawTextHelpFormatter)
    parser.add_argument('folder', type=str, help='Required. Path to the SLC folder.')
    args = parser.parse_args()
    query = search_dates(args.folder)
    write_file(query)



