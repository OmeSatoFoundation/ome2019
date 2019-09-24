#!/usr/bin/env python2
#encoding:utf-8
from __future__ import print_function
from bs4 import BeautifulSoup
import urllib2
import sys
    
def main():
    argc = len(sys.argv)
    argv = sys.argv
    if argc != 2:
        sys.exit(1)
    url = "http://www.ekidata.jp/api/l/"+ sys.argv[1].encode('utf-8') + ".xml"
    html = urllib2.urlopen(url).read()
    soup = BeautifulSoup(html, 'html.parser')
    stations = soup.find_all('station_name')
    for station in stations:
        print(station.get_text().encode('utf-8'), end=',')
if __name__ == '__main__':
    main()

