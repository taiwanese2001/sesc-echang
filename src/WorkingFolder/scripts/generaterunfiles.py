#!/usr/bin/python
import os
import sys

# need to change this when moving this script
#OUT_DIR='./'
OUT_DIR='../'

# don't need to change these when moving this script
COMBINED_OUT='runfile-all'
EXE_EXT='.mips'
OUT_EXT='.sh'
OUT_PRE='runfile-'
HEADER1='#!/bin/bash\n\n'
#LARGE_STACK='-k65536 '
LARGE_STACK='-k131072 '
STRING11='nice -10 ./$AUGSESC '
STRING12='-cconfigs/workFile/'
STRING2='.conf -dconfigs/workFile/'
STRING3='.conf.report benchmarks-splash2-sesc/'
STRING4=' &> console-outputs/'
STRING5='.$DATE.$HOSTNAME'

# parameters for benchmarks
BARNES_PARAMS_PRE='< benchmarks-splash2-sesc/barnes-inputs/cpu'
#BARNES_PARAMS_POST=''
BARNES_PARAMS_POST='-special'
CHOLESKY_PARAMS_PRE='-p'
#CHOLESKY_PARAMS_POST=' -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/wr10.O'
#CHOLESKY_PARAMS_POST=' -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/lshp.O'
#CHOLESKY_PARAMS_POST=' -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/tk23.O'
CHOLESKY_PARAMS_POST=' -B32 -C16384 -t < benchmarks-splash2-sesc/cholesky-inputs/tk15.O'
FFT_PARAMS_PRE='-m12 -p'
FFT_PARAMS_POST=' -n65536 -l4 -t'
FMM_PARAMS_PRE='-o < benchmarks-splash2-sesc/fmm-inputs/cpu'
FMM_PARAMS_POST=''
LU_PARAMS_PRE='-n256 -p'
LU_PARAMS_POST=' -b8 -t'
#LU_PARAMS_POST=' -b16 -t'
#LU_PARAMS_POST=' -b32 -t'
NEWTEST_PARAMS_PRE='-p'
#NEWTEST_PARAMS_POST=' -n10000'
NEWTEST_PARAMS_POST=' -n1000'
#OCEAN_PARAMS_PRE='-n130 -p'
OCEAN_PARAMS_PRE='-n258 -p'
OCEAN_PARAMS_POST=' -e1e-7 -r20000.0 -t28800.0'
RADIX_PARAMS_PRE='-p'
RADIX_PARAMS_POST=' -n262144 -r1024 -m524288'
#RADIX_PARAMS_POST=' -n524288 -r1024 -m524288'
RAYTRACE_PARAMS_PRE='-p'
RAYTRACE_PARAMS_POST=' benchmarks-splash2-sesc/raytrace-inputs/balls4.env'
READTEST_PARAMS_PRE='-p'
READTEST_PARAMS_POST=' -n1000'
WRITETEST_PARAMS_PRE='-p'
WRITETEST_PARAMS_POST=' -n1000'

thisFileName = sys.argv[0]
thisFileName = os.path.basename(thisFileName)

# converts the parameter to int with error checking
def convertToInt(incoming):
    try:
        outgoing = int(incoming)
    except ValueError:
        print(incoming + " is not an integer")
        quit()
    return outgoing

def generateOneRunfile(benchmarkName, directoryType, processorCount, L1Size, L2Size, CONFFILE_ADDITION):
    # check if these variables are numbers before using them
    processorCountInt = convertToInt(processorCount)
    L1SizeInt = convertToInt(L1Size)
    L2SizeInt = convertToInt(L2Size)
    isUseLargeStack = False

    if (benchmarkName=='barnes'):
        parameters = BARNES_PARAMS_PRE + processorCount + BARNES_PARAMS_POST
    elif (benchmarkName=='cholesky'):
        parameters = CHOLESKY_PARAMS_PRE + processorCount + CHOLESKY_PARAMS_POST
        isUseLargeStack = True
    elif (benchmarkName=='fft'):
        parameters = FFT_PARAMS_PRE + processorCount + FFT_PARAMS_POST
    elif (benchmarkName=='fmm'):
        parameters = FMM_PARAMS_PRE + processorCount + FMM_PARAMS_POST
    elif (benchmarkName=='lu'):
        parameters = LU_PARAMS_PRE + processorCount + LU_PARAMS_POST
    elif (benchmarkName=='newtest'):
        parameters = NEWTEST_PARAMS_PRE + processorCount + NEWTEST_PARAMS_POST
    elif (benchmarkName=='ocean'):
        parameters = OCEAN_PARAMS_PRE + processorCount + OCEAN_PARAMS_POST
    elif (benchmarkName=='radix'):
        parameters = RADIX_PARAMS_PRE + processorCount + RADIX_PARAMS_POST
    elif (benchmarkName=='raytrace'):
        parameters = RAYTRACE_PARAMS_PRE + processorCount + RAYTRACE_PARAMS_POST
    elif (benchmarkName=='readtest'):
        parameters = READTEST_PARAMS_PRE + processorCount + READTEST_PARAMS_POST
    elif (benchmarkName=='writetest'):
        parameters = WRITETEST_PARAMS_PRE + processorCount + WRITETEST_PARAMS_POST
    else:
        print('Unknown benchmark ' + benchmarkName)
        quit()

    confFilename = benchmarkName + '-' + directoryType + '-' + processorCount + '-' + L1Size + '-' + L2Size\
          + CONFFILE_ADDITION

    returnString = ''
    if (isUseLargeStack):
        returnString += STRING11 + LARGE_STACK
    else:
        returnString += STRING11
    returnString += STRING12 + confFilename + STRING2 + confFilename + STRING3 + benchmarkName + EXE_EXT\
        + ' ' + parameters + STRING4 + confFilename + STRING5
    return returnString

def generateMultipleRunfiles(combinedOutfile, benchmarkName, directoryType, processorCountLow,\
processorCountHi, L1Low, L1Hi, L2Low, L2Hi):
    # check if these variables are numbers before using them
    processorCountLowInt = convertToInt(processorCountLow)
    processorCountHiInt = convertToInt(processorCountHi)
    L1LowInt = convertToInt(L1Low)
    L1HiInt = convertToInt(L1Hi)
    L2LowInt = convertToInt(L2Low)
    L2HiInt = convertToInt(L2Hi)

    outFilename = OUT_PRE + benchmarkName + '-' + directoryType + '-all'
    outFilenameFull = outFilename + OUT_EXT

    outPath = OUT_DIR + outFilenameFull
    combinedOutfile.write('./'+outFilenameFull+'\n')
    outFile = open(outPath, 'wb')

    # start inputting data
    outputString = ''
    #outputString = generateOneRunfile(benchmarkName, directoryType, processorCountLow, L1Low, '4096')
    outFile.write(HEADER2)

    '''
    processorIndex = processorCountLowInt
    while (processorIndex <= processorCountHiInt):
        L1Index = L1LowInt
        while (L1Index <= L1HiInt):
            L2Index = L1Index * 2
            if (L2Index < L2LowInt):
                L2Index = L2LowInt
            while (L2Index <= L2HiInt):
                outputString += generateOneRunfile(benchmarkName, directoryType, str(processorIndex), str(L1Index), str(L2Index))
                outputString += '\n'
                #print(str(processorIndex) + ' ' + str(L1Index) + ' ' + str(L2Index))
                L2Index *= 2
            L1Index *= 2
        processorIndex *=2
    '''

    if (CONFFILE_ADDITION_PRE != ''):
        for number in LOCAL_SENDTIME_RANGE:
            CONFFILE_ADDITION = '.' + CONFFILE_ADDITION_PRE+str(number)+CONFFILE_ADDITION_POST
            L1Index = L1LowInt
            while (L1Index <= L1HiInt):
                processorIndex = processorCountLowInt
                while (processorIndex <= processorCountHiInt):
                    L2Index = L1Index * 2
                    if (L2Index < L2LowInt):
                        L2Index = L2LowInt
                    while (L2Index <= L2HiInt):
                        outputString += generateOneRunfile(benchmarkName, directoryType, str(processorIndex), str(L1Index), str(L2Index),
                            CONFFILE_ADDITION)
                        outputString += '\n'
                        #print(str(processorIndex) + ' ' + str(L1Index) + ' ' + str(L2Index))
                        L2Index *= 2
                    processorIndex *=2
                L1Index *= 2
    else:
        CONFFILE_ADDITION=''
        L1Index = L1LowInt
        while (L1Index <= L1HiInt):
            processorIndex = processorCountLowInt
            while (processorIndex <= processorCountHiInt):
                L2Index = L1Index * 2
                if (L2Index < L2LowInt):
                    L2Index = L2LowInt
                while (L2Index <= L2HiInt):
                    outputString += generateOneRunfile(benchmarkName, directoryType, str(processorIndex), str(L1Index), str(L2Index),
                        CONFFILE_ADDITION)
                    outputString += '\n'
                    #print(str(processorIndex) + ' ' + str(L1Index) + ' ' + str(L2Index))
                    L2Index *= 2
                processorIndex *=2
            L1Index *= 2
 
    outFile.write(outputString)
    outFile.close()
    os.chmod(outPath,0700)

def main():
    global AUGSESC
    global HEADER2
    #benchmarkNames = ['barnes', 'cholesky', 'fft', 'fmm', 'lu','newtest', 'radix', 'raytrace', 'ocean']
    #benchmarkNames = ['cholesky', 'fft', 'newtest', 'radix', 'ocean']
    #benchmarkNames = ['cholesky', 'fft', 'radix', 'ocean']
    benchmarkNames = ['readtest', 'writetest']
    directoryTypes = ['bip', 'origin']
    processorCountLow = '4'
    processorCountHi = '4'
    #L1Low = '8'
    #L1Hi = '64'
    L1Low = '64'
    L1Hi = '64'
    #L2Low = '128'
    #L2Low = '512'
    #L2Hi = '4096'
    L2Low = '512'
    L2Hi = '512'
    AUGSESC='augSesc-Debug'
    #AUGSESC='augSesc-Release'
    #AUGSESC='augSesc-O1'
    HEADER2='#!/bin/bash\nDATE=$(date "+%m%d%H%M")\nHOSTNAME=$(hostname)\nAUGSESC='+AUGSESC+'\n\n'
    global CONFFILE_ADDITION
    #CONFFILE_ADDITION=''
    global CONFFILE_ADDITION_PRE
    CONFFILE_ADDITION_PRE='localsendtime4-network'
    global CONFFILE_ADDITION_POST
    CONFFILE_ADDITION_POST='0'
    global LOCAL_SENDTIME_RANGE
    LOCAL_SENDTIME_RANGE=range(0,8)

    combinedOutfilename = OUT_DIR+COMBINED_OUT+OUT_EXT
    combinedOutfile = open(combinedOutfilename, 'wb')
    combinedOutfile.write(HEADER1)

    #generateMultipleRunfiles(benchmarkName, directoryType, processorCountLow,\
        #processorCountHi, L1Low, L1Hi, L2Low)

    for name in benchmarkNames:
        for directory in directoryTypes:
            generateMultipleRunfiles(combinedOutfile, name, directory, processorCountLow,\
                processorCountHi, L1Low, L1Hi, L2Low, L2Hi)

    combinedOutfile.close()
    # leading 0 implies octal
    os.chmod(combinedOutfilename,0700)

if __name__ == "__main__":
    main()
