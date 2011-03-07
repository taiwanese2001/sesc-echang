#!/bin/bash
DATE=$(date "+%m%d%H%M")
HOSTNAME=$(hostname)
AUGSESC=augSesc-Debug

nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-2-1-1024.conf -dconfigs/workFile/barnes-origin-2-1-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2-special &> console-outputs/barnes-origin-2-1-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-2-2-1024.conf -dconfigs/workFile/barnes-origin-2-2-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2-special &> console-outputs/barnes-origin-2-2-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-2-4-1024.conf -dconfigs/workFile/barnes-origin-2-4-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2-special &> console-outputs/barnes-origin-2-4-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-2-8-1024.conf -dconfigs/workFile/barnes-origin-2-8-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2-special &> console-outputs/barnes-origin-2-8-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-2-16-1024.conf -dconfigs/workFile/barnes-origin-2-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2-special &> console-outputs/barnes-origin-2-16-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-2-32-1024.conf -dconfigs/workFile/barnes-origin-2-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2-special &> console-outputs/barnes-origin-2-32-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-2-64-1024.conf -dconfigs/workFile/barnes-origin-2-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2-special &> console-outputs/barnes-origin-2-64-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-2-128-1024.conf -dconfigs/workFile/barnes-origin-2-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu2-special &> console-outputs/barnes-origin-2-128-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-4-1-1024.conf -dconfigs/workFile/barnes-origin-4-1-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4-special &> console-outputs/barnes-origin-4-1-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-4-2-1024.conf -dconfigs/workFile/barnes-origin-4-2-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4-special &> console-outputs/barnes-origin-4-2-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-4-4-1024.conf -dconfigs/workFile/barnes-origin-4-4-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4-special &> console-outputs/barnes-origin-4-4-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-4-8-1024.conf -dconfigs/workFile/barnes-origin-4-8-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4-special &> console-outputs/barnes-origin-4-8-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-4-16-1024.conf -dconfigs/workFile/barnes-origin-4-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4-special &> console-outputs/barnes-origin-4-16-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-4-32-1024.conf -dconfigs/workFile/barnes-origin-4-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4-special &> console-outputs/barnes-origin-4-32-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-4-64-1024.conf -dconfigs/workFile/barnes-origin-4-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4-special &> console-outputs/barnes-origin-4-64-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-4-128-1024.conf -dconfigs/workFile/barnes-origin-4-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu4-special &> console-outputs/barnes-origin-4-128-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-8-1-1024.conf -dconfigs/workFile/barnes-origin-8-1-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8-special &> console-outputs/barnes-origin-8-1-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-8-2-1024.conf -dconfigs/workFile/barnes-origin-8-2-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8-special &> console-outputs/barnes-origin-8-2-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-8-4-1024.conf -dconfigs/workFile/barnes-origin-8-4-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8-special &> console-outputs/barnes-origin-8-4-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-8-8-1024.conf -dconfigs/workFile/barnes-origin-8-8-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8-special &> console-outputs/barnes-origin-8-8-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-8-16-1024.conf -dconfigs/workFile/barnes-origin-8-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8-special &> console-outputs/barnes-origin-8-16-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-8-32-1024.conf -dconfigs/workFile/barnes-origin-8-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8-special &> console-outputs/barnes-origin-8-32-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-8-64-1024.conf -dconfigs/workFile/barnes-origin-8-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8-special &> console-outputs/barnes-origin-8-64-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-8-128-1024.conf -dconfigs/workFile/barnes-origin-8-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu8-special &> console-outputs/barnes-origin-8-128-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-16-1-1024.conf -dconfigs/workFile/barnes-origin-16-1-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16-special &> console-outputs/barnes-origin-16-1-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-16-2-1024.conf -dconfigs/workFile/barnes-origin-16-2-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16-special &> console-outputs/barnes-origin-16-2-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-16-4-1024.conf -dconfigs/workFile/barnes-origin-16-4-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16-special &> console-outputs/barnes-origin-16-4-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-16-8-1024.conf -dconfigs/workFile/barnes-origin-16-8-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16-special &> console-outputs/barnes-origin-16-8-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-16-16-1024.conf -dconfigs/workFile/barnes-origin-16-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16-special &> console-outputs/barnes-origin-16-16-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-16-32-1024.conf -dconfigs/workFile/barnes-origin-16-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16-special &> console-outputs/barnes-origin-16-32-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-16-64-1024.conf -dconfigs/workFile/barnes-origin-16-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16-special &> console-outputs/barnes-origin-16-64-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-16-128-1024.conf -dconfigs/workFile/barnes-origin-16-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu16-special &> console-outputs/barnes-origin-16-128-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-32-1-1024.conf -dconfigs/workFile/barnes-origin-32-1-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32-special &> console-outputs/barnes-origin-32-1-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-32-2-1024.conf -dconfigs/workFile/barnes-origin-32-2-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32-special &> console-outputs/barnes-origin-32-2-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-32-4-1024.conf -dconfigs/workFile/barnes-origin-32-4-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32-special &> console-outputs/barnes-origin-32-4-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-32-8-1024.conf -dconfigs/workFile/barnes-origin-32-8-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32-special &> console-outputs/barnes-origin-32-8-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-32-16-1024.conf -dconfigs/workFile/barnes-origin-32-16-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32-special &> console-outputs/barnes-origin-32-16-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-32-32-1024.conf -dconfigs/workFile/barnes-origin-32-32-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32-special &> console-outputs/barnes-origin-32-32-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-32-64-1024.conf -dconfigs/workFile/barnes-origin-32-64-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32-special &> console-outputs/barnes-origin-32-64-1024.$DATE.$HOSTNAME
nice -10 ./$AUGSESC -cconfigs/workFile/barnes-origin-32-128-1024.conf -dconfigs/workFile/barnes-origin-32-128-1024.conf.report benchmarks-splash2-sesc/barnes.mips < benchmarks-splash2-sesc/barnes-inputs/cpu32-special &> console-outputs/barnes-origin-32-128-1024.$DATE.$HOSTNAME
