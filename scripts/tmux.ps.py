#!/usr/bin/env python3
import io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

try:
    import psutil
except:
    print("psutil not found")
import sys
try:
    p = psutil.Process(pid=int(sys.argv[1]))
except psutil.NoSuchProcess:
    # get windows pid on msys2
    import subprocess
    pid = subprocess.run(["ps", "-p", sys.argv[1]], capture_output=True, text=True).stdout.split("\n")[1].split()[3]
    p = psutil.Process(pid=int(pid))
c1 = len(p.children())
c2 = len(p.children(recursive=True))
#print(sys.argv[2] + str(c1) + sys.argv[3] + str(c2))
print("jobs " + str(c1) + " #[fg=colour105]#[bg=colour105,fg=colour228]ps " + str(c2))