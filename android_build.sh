#! /bin/bash

#---Definitions---#
MY_ANDROID_AVDMANAGER=${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager
MY_ANDROID_ADB=${ANDROID_HOME}/platform-tools/adb
MY_ANDROID_EMULATOR=${ANDROID_HOME}/emulator/emulator
MY_ANDROID_MKSDCARD=${ANDROID_HOME}/emulator/mksdcard
MY_ANDROID_DEST_PATH=/data/local

MY_ANDROID_API0=16
MY_ANDROID_AVD_NAME0=armv7a-api16
MY_ANDROID_EMULATOR_PORT0=5554
MY_ANDROID_EMULATOR_SN0=emulator-${MY_ANDROID_EMULATOR_PORT0}
MY_PREFIX0=armv7a-linux-androideabi${MY_ANDROID_API0}-
MY_CC0=$(find ${ANDROID_NDK_LATEST_HOME} -name ${MY_PREFIX0}clang)
MY_APP0=${MY_PREFIX0}app

MY_ANDROID_API1=24
MY_ANDROID_AVD_NAME1=armv7a-api24
MY_ANDROID_EMULATOR_PORT1=5556
MY_ANDROID_EMULATOR_SN1=emulator-${MY_ANDROID_EMULATOR_PORT1}
MY_PREFIX1=armv7a-linux-androideabi${MY_ANDROID_API1}-
MY_CC1=$(find ${ANDROID_NDK_LATEST_HOME} -name ${MY_PREFIX1}clang)
MY_APP1=${MY_PREFIX1}app

#---Build---#
${MY_CC0} -Wall -Werror -o./${MY_APP0} ./main.c
${MY_CC1} -Wall -Werror -o./${MY_APP1} ./main.c

echo ________
echo ${MY_HELLO}
echo ________
#echo ________
#${ANDROID_HOME}/emulator/emulator -list-avds
#${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager list target -c
#echo ________
#${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager list device -c
#echo ________
#${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --list --include_obsolete
#echo ________

#echo ________
#${MY_ANDROID_AVDMANAGER} list avd -c
#echo ________
#${MY_ANDROID_MKSDCARD} 128M ./mySdCard.img
#mkdir ./sdcard
#sudo mount -o loop,sync,uid=$(echo `whoami`) ~/.android/avd/${MY_ANDROID_AVD_NAME0}.avd/sdcard.img ./sdcard
#sudo mount -o loop,sync,uid=$(echo `whoami`) ./mySdCard.img ./sdcard
#mv ./${MY_APP0} ./sdcard
#sudo umount ./sdcard
#rmdir ./sdcard
#echo ________

#---Start the emulators---#
#${MY_ANDROID_EMULATOR} -avd ${MY_ANDROID_AVD_NAME0} -no-window -no-audio -no-snapshot -sdcard ./mySdCard.img &
${MY_ANDROID_EMULATOR} -avd ${MY_ANDROID_AVD_NAME0} -port ${MY_ANDROID_EMULATOR_PORT0} -no-window -no-audio -no-snapshot &
${MY_ANDROID_EMULATOR} -avd ${MY_ANDROID_AVD_NAME1} -port ${MY_ANDROID_EMULATOR_PORT1} -no-window -no-audio -no-snapshot &

#---Wait for the emulators to be online---#
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN0} wait-for-device
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN1} wait-for-device
echo ________
${MY_ANDROID_ADB} devices
echo ________

#---Restart as root---#
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN0} root
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN1} root

#---Wait for the emulator to be ready---#
#${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN0} shell 'while [[ -z $(ls /sdcard/) ]]; do sleep 1; done;'
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN0} shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN1} shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'

#---Copy files---#
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN0} push ./${MY_APP0} ${MY_ANDROID_DEST_PATH}
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN1} push ./${MY_APP1} ${MY_ANDROID_DEST_PATH}

#---Run---#
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN0} shell ${MY_ANDROID_DEST_PATH}/${MY_APP0}
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN1} shell ${MY_ANDROID_DEST_PATH}/${MY_APP1}

#---Remove the application---#
#${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN0} shell rm ${MY_ANDROID_DEST_PATH}/${MY_APP0}
#${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN1} shell rm ${MY_ANDROID_DEST_PATH}/${MY_APP1}

#---Restart as unroot---#
#${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN0} unroot
#${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN1} unroot
