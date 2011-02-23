#!/bin/bash
DATE=$(date "+%m%d%H%M")
HOSTNAME=$(hostname)

nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-2-16-1024.conf -dconfigs/workFile/ocean-origin-2-16-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p2 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-2-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-2-32-1024.conf -dconfigs/workFile/ocean-origin-2-32-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p2 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-2-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-2-64-1024.conf -dconfigs/workFile/ocean-origin-2-64-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p2 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-2-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-2-128-1024.conf -dconfigs/workFile/ocean-origin-2-128-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p2 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-2-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-4-16-1024.conf -dconfigs/workFile/ocean-origin-4-16-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p4 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-4-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-4-32-1024.conf -dconfigs/workFile/ocean-origin-4-32-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p4 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-4-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-4-64-1024.conf -dconfigs/workFile/ocean-origin-4-64-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p4 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-4-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-4-128-1024.conf -dconfigs/workFile/ocean-origin-4-128-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p4 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-4-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-8-16-1024.conf -dconfigs/workFile/ocean-origin-8-16-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p8 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-8-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-8-32-1024.conf -dconfigs/workFile/ocean-origin-8-32-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p8 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-8-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-8-64-1024.conf -dconfigs/workFile/ocean-origin-8-64-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p8 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-8-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-8-128-1024.conf -dconfigs/workFile/ocean-origin-8-128-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p8 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-8-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-16-16-1024.conf -dconfigs/workFile/ocean-origin-16-16-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p16 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-16-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-16-32-1024.conf -dconfigs/workFile/ocean-origin-16-32-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p16 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-16-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-16-64-1024.conf -dconfigs/workFile/ocean-origin-16-64-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p16 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-16-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-16-128-1024.conf -dconfigs/workFile/ocean-origin-16-128-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p16 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-16-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-32-16-1024.conf -dconfigs/workFile/ocean-origin-32-16-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p32 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-32-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-32-32-1024.conf -dconfigs/workFile/ocean-origin-32-32-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p32 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-32-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-32-64-1024.conf -dconfigs/workFile/ocean-origin-32-64-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p32 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-32-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/ocean-origin-32-128-1024.conf -dconfigs/workFile/ocean-origin-32-128-1024.conf.report benchmarks-splash2-sesc/ocean.mips -n130 -p32 -e1e-7 -r20000.0 -t28800.0 &> console-outputs/ocean-origin-32-128-1024.$DATE.$HOSTNAME
