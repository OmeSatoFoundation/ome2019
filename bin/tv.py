#!/usr/bin/env python2
#encoding:utf-8
from __future__ import print_function
from bs4 import BeautifulSoup
import urllib2
import sys

def getprogram(word):
    url = 'https://tv.yahoo.co.jp/search/?q=' + word.encode('utf-8')
    html = urllib2.urlopen(url).read()

    soup = BeautifulSoup(html, 'html.parser')
    dt = soup.find_all('div', class_='leftarea')
    pn = soup.find_all('div', class_='rightarea')

    for i in range(len(dt)):
        d = dt[i].find_all("em")[0].string.encode('utf-8') #date
        t = dt[i].find_all("em")[1].string.encode('utf-8') #time
        n = pn[i].find_all("a")[0].string.replace('\u3000', '').encode('utf-8')
        s = pn[i].find_all("span")[0].string.encode('utf-8')
        print(d.strip(), end=",")
        print(t.strip(), end=",")
        print(n.strip(), end=",")
        print(s.strip(), end=",")
        print('')

        

    
def main():
    argc = len(sys.argv)
    argv = sys.argv
    if argc != 2:
        sys.exit(1)
    getprogram(argv[1].decode('utf-8'))


if __name__ == '__main__':
    main()

