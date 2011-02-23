#!/bin/bash
HOSTNAME=$(hostname)

nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-2-16-1024.conf -dconfigs/workFile/raytrace-origin-2-16-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p2 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-2-16-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-2-32-1024.conf -dconfigs/workFile/raytrace-origin-2-32-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p2 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-2-32-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-2-64-1024.conf -dconfigs/workFile/raytrace-origin-2-64-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p2 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-2-64-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-2-128-1024.conf -dconfigs/workFile/raytrace-origin-2-128-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p2 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-2-128-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-4-16-1024.conf -dconfigs/workFile/raytrace-origin-4-16-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p4 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-4-16-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-4-32-1024.conf -dconfigs/workFile/raytrace-origin-4-32-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p4 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-4-32-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-4-64-1024.conf -dconfigs/workFile/raytrace-origin-4-64-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p4 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-4-64-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-4-128-1024.conf -dconfigs/workFile/raytrace-origin-4-128-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p4 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-4-128-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-8-16-1024.conf -dconfigs/workFile/raytrace-origin-8-16-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p8 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-8-16-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-8-32-1024.conf -dconfigs/workFile/raytrace-origin-8-32-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p8 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-8-32-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-8-64-1024.conf -dconfigs/workFile/raytrace-origin-8-64-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p8 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-8-64-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-8-128-1024.conf -dconfigs/workFile/raytrace-origin-8-128-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p8 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-8-128-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-16-16-1024.conf -dconfigs/workFile/raytrace-origin-16-16-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p16 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-16-16-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-16-32-1024.conf -dconfigs/workFile/raytrace-origin-16-32-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p16 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-16-32-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-16-64-1024.conf -dconfigs/workFile/raytrace-origin-16-64-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p16 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-16-64-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-16-128-1024.conf -dconfigs/workFile/raytrace-origin-16-128-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p16 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-16-128-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-32-16-1024.conf -dconfigs/workFile/raytrace-origin-32-16-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p32 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-32-16-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-32-32-1024.conf -dconfigs/workFile/raytrace-origin-32-32-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p32 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-32-32-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-32-64-1024.conf -dconfigs/workFile/raytrace-origin-32-64-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p32 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-32-64-1024.out.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/raytrace-origin-32-128-1024.conf -dconfigs/workFile/raytrace-origin-32-128-1024.conf.report benchmarks-splash2-sesc/raytrace.mips -p32 benchmarks-splash2-sesc/raytrace-inputs/balls4.env &> console-outputs/raytrace-origin-32-128-1024.out.$HOSTNAME
