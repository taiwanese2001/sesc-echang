#!/bin/bash
HOSTNAME=$(hostname)

nice -10 ./augSesc -cconfigs/workFile/barnes-dir-moesi-002-0001-0002-00.conf -dconfigs/workFile/barnes-dir-moesi-002-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu2   &> console-outputs/barnes-dir-moesi-002-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-dir-msi-002-0001-0002-00.conf -dconfigs/workFile/barnes-dir-msi-002-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu2   &> console-outputs/barnes-dir-msi-002-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-moesi-002-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-moesi-002-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu2   &> console-outputs/barnes-3sd-moesi-002-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-msi-002-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-msi-002-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu2   &> console-outputs/barnes-3sd-msi-002-0001-0002-00.out.$HOSTNAME

nice -10 ./augSesc -cconfigs/workFile/barnes-dir-moesi-004-0001-0002-00.conf -dconfigs/workFile/barnes-dir-moesi-004-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu4   &> console-outputs/barnes-dir-moesi-004-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-dir-msi-004-0001-0002-00.conf -dconfigs/workFile/barnes-dir-msi-004-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu4   &> console-outputs/barnes-dir-msi-004-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-moesi-004-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-moesi-004-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu4   &> console-outputs/barnes-3sd-moesi-004-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-msi-004-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-msi-004-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu4   &> console-outputs/barnes-3sd-msi-004-0001-0002-00.out.$HOSTNAME

nice -10 ./augSesc -cconfigs/workFile/barnes-dir-moesi-008-0001-0002-00.conf -dconfigs/workFile/barnes-dir-moesi-008-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu8   &> console-outputs/barnes-dir-moesi-008-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-dir-msi-008-0001-0002-00.conf -dconfigs/workFile/barnes-dir-msi-008-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu8   &> console-outputs/barnes-dir-msi-008-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-moesi-008-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-moesi-008-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu8   &> console-outputs/barnes-3sd-moesi-008-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-msi-008-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-msi-008-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu8   &> console-outputs/barnes-3sd-msi-008-0001-0002-00.out.$HOSTNAME

nice -10 ./augSesc -cconfigs/workFile/barnes-dir-moesi-016-0001-0002-00.conf -dconfigs/workFile/barnes-dir-moesi-016-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu16   &> console-outputs/barnes-dir-moesi-016-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-dir-msi-016-0001-0002-00.conf -dconfigs/workFile/barnes-dir-msi-016-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu16   &> console-outputs/barnes-dir-msi-016-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-moesi-016-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-moesi-016-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu16   &> console-outputs/barnes-3sd-moesi-016-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-msi-016-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-msi-016-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu16   &> console-outputs/barnes-3sd-msi-016-0001-0002-00.out.$HOSTNAME

nice -10 ./augSesc -cconfigs/workFile/barnes-dir-moesi-032-0001-0002-00.conf -dconfigs/workFile/barnes-dir-moesi-032-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu32   &> console-outputs/barnes-dir-moesi-032-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-dir-msi-032-0001-0002-00.conf -dconfigs/workFile/barnes-dir-msi-032-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu32   &> console-outputs/barnes-dir-msi-032-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-moesi-032-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-moesi-032-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu32   &> console-outputs/barnes-3sd-moesi-032-0001-0002-00.out.$HOSTNAME
nice -10 ./augSesc -cconfigs/workFile/barnes-3sd-msi-032-0001-0002-00.conf -dconfigs/workFile/barnes-3sd-msi-032-0001-0002-00.conf.report benchmarks-splash2-sesc//barnes.mips   < benchmarks-splash2-sesc/barnes-inputs/cpu32   &> console-outputs/barnes-3sd-msi-032-0001-0002-00.out.$HOSTNAME

