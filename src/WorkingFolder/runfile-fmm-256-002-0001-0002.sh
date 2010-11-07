#!/bin/bash
HOSTNAME=$(hostname)

nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-00.conf -dconfigs/workFile/fmm-256-002-0001-0002-00.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-01.conf -dconfigs/workFile/fmm-256-002-0001-0002-01.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-01.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-02.conf -dconfigs/workFile/fmm-256-002-0001-0002-02.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-02.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-03.conf -dconfigs/workFile/fmm-256-002-0001-0002-03.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-03.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-04.conf -dconfigs/workFile/fmm-256-002-0001-0002-04.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-04.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-05.conf -dconfigs/workFile/fmm-256-002-0001-0002-05.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-05.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-06.conf -dconfigs/workFile/fmm-256-002-0001-0002-06.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-06.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-07.conf -dconfigs/workFile/fmm-256-002-0001-0002-07.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-07.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-08.conf -dconfigs/workFile/fmm-256-002-0001-0002-08.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-08.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-09.conf -dconfigs/workFile/fmm-256-002-0001-0002-09.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-09.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-10.conf -dconfigs/workFile/fmm-256-002-0001-0002-10.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-10.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-11.conf -dconfigs/workFile/fmm-256-002-0001-0002-11.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-11.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-12.conf -dconfigs/workFile/fmm-256-002-0001-0002-12.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-12.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-13.conf -dconfigs/workFile/fmm-256-002-0001-0002-13.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-13.out.$HOSTNAME
nice -10 ./augSesc-non-verbose  -cconfigs/workFile/fmm-256-002-0001-0002-14.conf -dconfigs/workFile/fmm-256-002-0001-0002-14.report benchmarks-splash2-sesc/fmm.mips -o < benchmarks-splash2-sesc/fmm-inputs/input.256 &> console-outputs/fmm-002-0001-0002-14.out.$HOSTNAME
