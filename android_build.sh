#! /bin/bash

#---Definitions---#
#ANDROID_HOME=/home/cedric/apps/x86_64-gnu/dev/android-sdk
#ANDROID_EMULATOR_SN=emulator-5554
#ANDROID_ADB="${ANDROID_HOME}/platform-tools/adb -s ${ANDROID_EMULATOR_SN}"
#ANDROID_DEST_PATH=/data/local
ANDROID_API=16
#ANDROID_API=24
MY_PREFIX=armv7a-linux-androideabi${ANDROID_API}-

#---Restart as root---#
#${ANDROID_ADB} root

#---Build---#
CC=$(find ${ANDROID_NDK_LATEST_HOME} -name ${MY_PREFIX}clang)
${CC} -Wall -Werror -o./app	\
	./main.c

echo ________
#${ANDROID_HOME}/emulator/emulator -list-avds
${ANDROID_HOME}/tools/bin/avdmanager list target -c
echo ________
${ANDROID_HOME}/tools/bin/avdmanager list device -c
echo ________
${ANDROID_HOME}/tools/bin/avdmanager list avd -c
echo ________

#---Copy files---#
#${ANDROID_ADB} push ./app ${ANDROID_DEST_PATH}

#---Run---#
#${ANDROID_ADB} shell date
#${ANDROID_ADB} shell ${ANDROID_DEST_PATH}/app
#${ANDROID_ADB} shell date

#---Remove the application---#
#${ANDROID_ADB} shell rm ${ANDROID_DEST_PATH}/app

#---Restart as unroot---#
#${ANDROID_ADB} unroot
