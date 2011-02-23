#!/bin/bash
DATE=$(date "+%m%d%H%M")
HOSTNAME=$(hostname)

nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-2-16-1024.conf -dconfigs/workFile/barnes-origin-2-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2 &> console-outputs/barnes-origin-2-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-2-32-1024.conf -dconfigs/workFile/barnes-origin-2-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2 &> console-outputs/barnes-origin-2-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-2-64-1024.conf -dconfigs/workFile/barnes-origin-2-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2 &> console-outputs/barnes-origin-2-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-2-128-1024.conf -dconfigs/workFile/barnes-origin-2-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2 &> console-outputs/barnes-origin-2-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-4-16-1024.conf -dconfigs/workFile/barnes-origin-4-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4 &> console-outputs/barnes-origin-4-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-4-32-1024.conf -dconfigs/workFile/barnes-origin-4-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4 &> console-outputs/barnes-origin-4-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-4-64-1024.conf -dconfigs/workFile/barnes-origin-4-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4 &> console-outputs/barnes-origin-4-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-4-128-1024.conf -dconfigs/workFile/barnes-origin-4-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4 &> console-outputs/barnes-origin-4-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-8-16-1024.conf -dconfigs/workFile/barnes-origin-8-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8 &> console-outputs/barnes-origin-8-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-8-32-1024.conf -dconfigs/workFile/barnes-origin-8-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8 &> console-outputs/barnes-origin-8-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-8-64-1024.conf -dconfigs/workFile/barnes-origin-8-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8 &> console-outputs/barnes-origin-8-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-8-128-1024.conf -dconfigs/workFile/barnes-origin-8-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8 &> console-outputs/barnes-origin-8-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-16-16-1024.conf -dconfigs/workFile/barnes-origin-16-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16 &> console-outputs/barnes-origin-16-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-16-32-1024.conf -dconfigs/workFile/barnes-origin-16-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16 &> console-outputs/barnes-origin-16-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-16-64-1024.conf -dconfigs/workFile/barnes-origin-16-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16 &> console-outputs/barnes-origin-16-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-16-128-1024.conf -dconfigs/workFile/barnes-origin-16-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16 &> console-outputs/barnes-origin-16-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-32-16-1024.conf -dconfigs/workFile/barnes-origin-32-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32 &> console-outputs/barnes-origin-32-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-32-32-1024.conf -dconfigs/workFile/barnes-origin-32-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32 &> console-outputs/barnes-origin-32-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-32-64-1024.conf -dconfigs/workFile/barnes-origin-32-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32 &> console-outputs/barnes-origin-32-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/barnes-origin-32-128-1024.conf -dconfigs/workFile/barnes-origin-32-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32 &> console-outputs/barnes-origin-32-128-1024.$DATE.$HOSTNAME
