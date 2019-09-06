#!/usr/bin/python3
import time
import sys

a=  """space 123
pulse 456
space 789
pulse 012
space 345
pulse 678
space 901
pulse 234
space 567
pulse 890 """

for b in a.split('\n'):
    print(b)
    sys.stdout.flush()
    time.sleep(1)
