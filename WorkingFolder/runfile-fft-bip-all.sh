#!/bin/bash
DATE=$(date "+%m%d%H%M")
HOSTNAME=$(hostname)

nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-2-16-1024.conf -dconfigs/workFile/fft-bip-2-16-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p2 -n65536 -l4 -t &> console-outputs/fft-bip-2-16-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-2-32-1024.conf -dconfigs/workFile/fft-bip-2-32-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p2 -n65536 -l4 -t &> console-outputs/fft-bip-2-32-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-2-64-1024.conf -dconfigs/workFile/fft-bip-2-64-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p2 -n65536 -l4 -t &> console-outputs/fft-bip-2-64-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-2-128-1024.conf -dconfigs/workFile/fft-bip-2-128-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p2 -n65536 -l4 -t &> console-outputs/fft-bip-2-128-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-4-16-1024.conf -dconfigs/workFile/fft-bip-4-16-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p4 -n65536 -l4 -t &> console-outputs/fft-bip-4-16-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-4-32-1024.conf -dconfigs/workFile/fft-bip-4-32-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p4 -n65536 -l4 -t &> console-outputs/fft-bip-4-32-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-4-64-1024.conf -dconfigs/workFile/fft-bip-4-64-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p4 -n65536 -l4 -t &> console-outputs/fft-bip-4-64-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-4-128-1024.conf -dconfigs/workFile/fft-bip-4-128-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p4 -n65536 -l4 -t &> console-outputs/fft-bip-4-128-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-8-16-1024.conf -dconfigs/workFile/fft-bip-8-16-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p8 -n65536 -l4 -t &> console-outputs/fft-bip-8-16-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-8-32-1024.conf -dconfigs/workFile/fft-bip-8-32-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p8 -n65536 -l4 -t &> console-outputs/fft-bip-8-32-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-8-64-1024.conf -dconfigs/workFile/fft-bip-8-64-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p8 -n65536 -l4 -t &> console-outputs/fft-bip-8-64-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-8-128-1024.conf -dconfigs/workFile/fft-bip-8-128-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p8 -n65536 -l4 -t &> console-outputs/fft-bip-8-128-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-16-16-1024.conf -dconfigs/workFile/fft-bip-16-16-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p16 -n65536 -l4 -t &> console-outputs/fft-bip-16-16-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-16-32-1024.conf -dconfigs/workFile/fft-bip-16-32-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p16 -n65536 -l4 -t &> console-outputs/fft-bip-16-32-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-16-64-1024.conf -dconfigs/workFile/fft-bip-16-64-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p16 -n65536 -l4 -t &> console-outputs/fft-bip-16-64-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-16-128-1024.conf -dconfigs/workFile/fft-bip-16-128-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p16 -n65536 -l4 -t &> console-outputs/fft-bip-16-128-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-32-16-1024.conf -dconfigs/workFile/fft-bip-32-16-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p32 -n65536 -l4 -t &> console-outputs/fft-bip-32-16-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-32-32-1024.conf -dconfigs/workFile/fft-bip-32-32-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p32 -n65536 -l4 -t &> console-outputs/fft-bip-32-32-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-32-64-1024.conf -dconfigs/workFile/fft-bip-32-64-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p32 -n65536 -l4 -t &> console-outputs/fft-bip-32-64-1024.out.$HOSTNAME.$DATE
nice -10 ./augSesc-Debug -cconfigs/workFile/fft-bip-32-128-1024.conf -dconfigs/workFile/fft-bip-32-128-1024.conf.report benchmarks-splash2-sesc/fft.mips -m10 -p32 -n65536 -l4 -t &> console-outputs/fft-bip-32-128-1024.out.$HOSTNAME.$DATE
