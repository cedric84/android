#! /bin/bash

#---Definitions---#
MY_ANDROID_AVDMANAGER=${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager
MY_ANDROID_ADB=${ANDROID_HOME}/platform-tools/adb
MY_ANDROID_EMULATOR=${ANDROID_HOME}/emulator/emulator
MY_ANDROID_MKSDCARD=${ANDROID_HOME}/emulator/mksdcard
MY_ANDROID_AVD_NAME=armv7a-api16
MY_ANDROID_EMULATOR_PORT=5554
MY_ANDROID_EMULATOR_SN=emulator-${MY_ANDROID_EMULATOR_PORT}
MY_ANDROID_DEST_PATH=/data/local
MY_ANDROID_API=16
#MY_ANDROID_API=24
MY_PREFIX=armv7a-linux-androideabi${MY_ANDROID_API}-

#---Build---#
CC=$(find ${ANDROID_NDK_LATEST_HOME} -name ${MY_PREFIX}clang)
${CC} -Wall -Werror -o./app	\
	./main.c

#echo ________
#${ANDROID_HOME}/emulator/emulator -list-avds
#${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager list target -c
#echo ________
#${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager list device -c
echo ________
${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --list --include_obsolete
echo ________

#echo ________
#${MY_ANDROID_AVDMANAGER} list avd -c
#echo ________
#${MY_ANDROID_MKSDCARD} 128M ./mySdCard.img
#mkdir ./sdcard
#sudo mount -o loop,sync,uid=$(echo `whoami`) ~/.android/avd/${MY_ANDROID_AVD_NAME}.avd/sdcard.img ./sdcard
#sudo mount -o loop,sync,uid=$(echo `whoami`) ./mySdCard.img ./sdcard
#mv ./app ./sdcard
#sudo umount ./sdcard
#rmdir ./sdcard
#echo ________

#---Start the emulator---#
#${MY_ANDROID_EMULATOR} -avd ${MY_ANDROID_AVD_NAME} -no-window -no-audio -no-snapshot -sdcard ./mySdCard.img &
${MY_ANDROID_EMULATOR} -avd ${MY_ANDROID_AVD_NAME} -port ${MY_ANDROID_EMULATOR_PORT} -no-window -no-audio -no-snapshot &

#---Wait for the emulator to be ready---#
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN} wait-for-device
#${MY_ANDROID_ADB} devices
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN} shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'
#${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN} shell 'while [[ -z $(ls /sdcard/) ]]; do sleep 1; done;'

#---Restart as root---#
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN} root

#---Copy files---#
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN} push ./app ${MY_ANDROID_DEST_PATH}

#---Run---#
${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN} shell ${MY_ANDROID_DEST_PATH}/app

#---Remove the application---#
#${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN} shell rm ${MY_ANDROID_DEST_PATH}/app

#---Restart as unroot---#
#${MY_ANDROID_ADB} -s ${MY_ANDROID_EMULATOR_SN} unroot
