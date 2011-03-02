#!/bin/bash
DATE=$(date "+%m%d%H%M")
HOSTNAME=$(hostname)

nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-2-16-1024.conf -dconfigs/workFile/cholesky-directory-2-16-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p2 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-2-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-2-32-1024.conf -dconfigs/workFile/cholesky-directory-2-32-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p2 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-2-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-2-64-1024.conf -dconfigs/workFile/cholesky-directory-2-64-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p2 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-2-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-2-128-1024.conf -dconfigs/workFile/cholesky-directory-2-128-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p2 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-2-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-4-16-1024.conf -dconfigs/workFile/cholesky-directory-4-16-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p4 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-4-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-4-32-1024.conf -dconfigs/workFile/cholesky-directory-4-32-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p4 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-4-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-4-64-1024.conf -dconfigs/workFile/cholesky-directory-4-64-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p4 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-4-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-4-128-1024.conf -dconfigs/workFile/cholesky-directory-4-128-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p4 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-4-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-8-16-1024.conf -dconfigs/workFile/cholesky-directory-8-16-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p8 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-8-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-8-32-1024.conf -dconfigs/workFile/cholesky-directory-8-32-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p8 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-8-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-8-64-1024.conf -dconfigs/workFile/cholesky-directory-8-64-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p8 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-8-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-8-128-1024.conf -dconfigs/workFile/cholesky-directory-8-128-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p8 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-8-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-16-16-1024.conf -dconfigs/workFile/cholesky-directory-16-16-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p16 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-16-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-16-32-1024.conf -dconfigs/workFile/cholesky-directory-16-32-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p16 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-16-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-16-64-1024.conf -dconfigs/workFile/cholesky-directory-16-64-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p16 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-16-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-16-128-1024.conf -dconfigs/workFile/cholesky-directory-16-128-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p16 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-16-128-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-32-16-1024.conf -dconfigs/workFile/cholesky-directory-32-16-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p32 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-32-16-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-32-32-1024.conf -dconfigs/workFile/cholesky-directory-32-32-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p32 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-32-32-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-32-64-1024.conf -dconfigs/workFile/cholesky-directory-32-64-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p32 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-32-64-1024.$DATE.$HOSTNAME
nice -10 ./augSesc-Debug -cconfigs/workFile/cholesky-directory-32-128-1024.conf -dconfigs/workFile/cholesky-directory-32-128-1024.conf.report benchmarks-splash2-sesc/cholesky.mips -p32 -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O &> console-outputs/cholesky-directory-32-128-1024.$DATE.$HOSTNAME
