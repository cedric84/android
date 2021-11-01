#! /bin/bash

#---Definitions---#
#ANDROID_HOME=/home/cedric/apps/x86_64-gnu/dev/android-sdk
#ANDROID_EMULATOR_SN=emulator-5554
#ANDROID_ADB="${ANDROID_HOME}/platform-tools/adb -s ${ANDROID_EMULATOR_SN}"
#ANDROID_DEST_PATH=/data/local
ANDROID_API=16
#ANDROID_API=24

#---Restart as root---#
#${ANDROID_ADB} root

#---Build---#
#CC=${ANDROID_NDK_LATEST_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi${ANDROID_API}-clang
CC=$(find ${ANDROID_NDK_LATEST_HOME} -name armv7a-linux-androideabi${ANDROID_API}-clang)
echo ${CC}
${CC} -Wall -Werror -o./app	\
	./main.c

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
