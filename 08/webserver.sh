#!/bin/bash 
mkdir tmp/
python2 -m CGIHTTPServer 3000
rm -rf tmp/
