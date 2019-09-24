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
    url = 'http://zip.cgis.biz/xml/zip.php?zn=' + sys.argv[1].encode('utf-8')
    html = urllib2.urlopen(url).read()
    soup = BeautifulSoup(html, 'html.parser')
    value = soup.find_all('value')
    result = dict()
    for v in value:
        result.update(v.attrs)
    print(result['state'].encode('utf-8'), end=',')
    print(result['city'].encode('utf-8'), end=',')
    print(result['address'].encode('utf-8'), end=',')

if __name__ == '__main__':
    main()

