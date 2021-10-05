#!/usr/bin/env python2
#encoding:utf-8
#使用したAPIはHeart Rails Expressです
#https://express.heartrails.com/api.html

from __future__ import print_function
from bs4 import BeautifulSoup
import urllib2
import sys
import urllib
def search_meaning(keido,ido):
	keido= keido.decode('utf-8')
	ido=ido.decode('utf-8')
	keido=urllib.quote(keido.encode('utf-8'))
	ido=urllib.quote(ido.encode('utf-8'))
	url = 'http://express.heartrails.com/api/xml?method=getStations&x='+keido+'&y='+ido
	html = urllib2.urlopen(url).read()
	soup = BeautifulSoup(html, "html.parser")
        for i in  soup.find_all('station'):
            name = i.find('name').string
            line = i.find('line').string
            name=name.encode('utf-8')
            line=line.encode('utf-8')
            print(name+','+line)
	return 0

def main():
	argc = len(sys.argv)
	argv = sys.argv
	search_meaning(argv[1],argv[2])
	return 0
    
if __name__ == '__main__':
	main()

