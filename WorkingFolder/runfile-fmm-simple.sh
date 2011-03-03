#!/bin/bash
DATE=$(date "+%m%d%H%M")
HOSTNAME=$(hostname)

#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-2-16-1024.conf -dconfigs/workFile/fmm-bip-2-16-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu2 &> console-outputs/fmm-bip-2-16-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-2-32-1024.conf -dconfigs/workFile/fmm-bip-2-32-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu2 &> console-outputs/fmm-bip-2-32-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-2-64-1024.conf -dconfigs/workFile/fmm-bip-2-64-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu2 &> console-outputs/fmm-bip-2-64-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-2-128-1024.conf -dconfigs/workFile/fmm-bip-2-128-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu2 &> console-outputs/fmm-bip-2-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-origin-4-16-1024.conf -dconfigs/workFile/fmm-origin-4-16-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/special
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-4-16-1024.conf -dconfigs/workFile/fmm-bip-4-16-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/special &> console-outputs/fmm-bip-4-16-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-4-32-1024.conf -dconfigs/workFile/fmm-bip-4-32-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu4 &> console-outputs/fmm-bip-4-32-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-4-64-1024.conf -dconfigs/workFile/fmm-bip-4-64-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu4 &> console-outputs/fmm-bip-4-64-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-4-128-1024.conf -dconfigs/workFile/fmm-bip-4-128-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu4 &> console-outputs/fmm-bip-4-128-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-8-16-1024.conf -dconfigs/workFile/fmm-bip-8-16-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu8 &> console-outputs/fmm-bip-8-16-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-8-32-1024.conf -dconfigs/workFile/fmm-bip-8-32-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu8 &> console-outputs/fmm-bip-8-32-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-8-64-1024.conf -dconfigs/workFile/fmm-bip-8-64-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu8 &> console-outputs/fmm-bip-8-64-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-8-128-1024.conf -dconfigs/workFile/fmm-bip-8-128-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu8 &> console-outputs/fmm-bip-8-128-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-16-16-1024.conf -dconfigs/workFile/fmm-bip-16-16-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu16 &> console-outputs/fmm-bip-16-16-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-16-32-1024.conf -dconfigs/workFile/fmm-bip-16-32-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu16 &> console-outputs/fmm-bip-16-32-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-16-64-1024.conf -dconfigs/workFile/fmm-bip-16-64-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu16 &> console-outputs/fmm-bip-16-64-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-16-128-1024.conf -dconfigs/workFile/fmm-bip-16-128-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu16 &> console-outputs/fmm-bip-16-128-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-32-16-1024.conf -dconfigs/workFile/fmm-bip-32-16-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu32 &> console-outputs/fmm-bip-32-16-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-32-32-1024.conf -dconfigs/workFile/fmm-bip-32-32-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu32 &> console-outputs/fmm-bip-32-32-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-32-64-1024.conf -dconfigs/workFile/fmm-bip-32-64-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu32 &> console-outputs/fmm-bip-32-64-1024.$DATE.$HOSTNAME
#nice -10 ./augSesc-Debug -cconfigs/workFile/fmm-bip-32-128-1024.conf -dconfigs/workFile/fmm-bip-32-128-1024.conf.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/cpu32 &> console-outputs/fmm-bip-32-128-1024.$DATE.$HOSTNAME
