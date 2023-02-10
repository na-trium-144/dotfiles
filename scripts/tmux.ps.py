#!/usr/bin/env python3
try:
    import psutil
except:
    print("psutil not found")
import sys
p = psutil.Process(pid=int(sys.argv[1]))
c1 = len(p.children())
c2 = len(p.children(recursive=True))
print(sys.argv[2] + str(c1) + sys.argv[3] + str(c2))