#!/usr/bin/env python2
#encoding:utf-8
from __future__ import print_function
import sys
import urllib2
from bs4 import BeautifulSoup

all_args = {'tag': {'arg': ['', '--print-headers'], 'description': 'ヘッダーの表示'},
            'help': {'arg': ['-h', '--help'], 'description':'ヘルプを表示する'}}
def usage():
    global all_args
    print("{} options".format(sys.argv[0]))
    for k, v in all_args.items():
        print("{} {}: {}".format(v['arg'][0], v['arg'][1], v['description']))
    sys.exit()
def main():
    print_with_headers = False 
    html = urllib2.urlopen('http://tenki.jp/amedas/3/16/44056.html').read()
    soup = BeautifulSoup(html, 'html.parser')
    table = soup.find_all('table', attrs={'class' : 'common-list-entries amedas-table-entries'})[0] 
    tr = [i for i in table.find_all('tr')[:2]] #headers and current data in 10 min basis
    result = []
    for i in tr:
        result.append(i.text.strip())
    headers = [i for i in result[0].splitlines()]
    data    = [i for i in result[1].splitlines()]
    if(len(sys.argv) > 1):
        if('--print-headers' in sys.argv):
            print_with_headers = True
    if print_with_headers:
        print('青梅市のアメダスの記録(10分観測値)')
        for h, d in zip(headers, data):
            print(h.encode('utf-8'), end=' : ')
            print(d.encode('utf-8'))
    else:
        i = 0
        for d in data:
            if i == 0:
               d = d.split(' ')[1] #extract time (format for this feild is 'date time')
            i += 1
            print(d.encode('utf-8'), end=',')
    return 0
if __name__ == '__main__':
    sys.exit(main())
