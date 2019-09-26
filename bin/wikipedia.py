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
    url = "https://ja.wikipedia.org/wiki/" + sys.argv[1]
    try:
        html = urllib2.urlopen(url).read()
    except urllib2.HTTPError as e:
        print(e)
        sys.exit(1)
    soup = BeautifulSoup(html, 'html.parser')
    ps = soup.find_all('p')
    for p in ps:
        print(p.get_text().encode('utf-8'), end=',')
if __name__ == '__main__':
    main()

