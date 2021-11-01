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

#echo ________
#${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager "system-images;android-16;default;armeabi-v7a"
#echo ________
#echo -ne '\n' | \
#${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager -s create avd -n "armv7a-api16" -k "system-images;android-16;default;armeabi-v7a"
#echo ________
#${ANDROID_HOME}/emulator/emulator -list-avds
#${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager list target -c
#echo ________
#${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager list device -c
#echo ________
#${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --list
#echo ________

ANDROID_AVDMANAGER=${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager
ANDROID_ADB=${ANDROID_HOME}/platform-tools/adb
ANDROID_EMULATOR=${ANDROID_HOME}/emulator/emulator
ANDROID_AVD_NAME=armv7a-api16
echo ________
${ANDROID_AVDMANAGER} list avd -c
#echo ________
#find / -name .emulator_console_auth_token
#echo ________
echo ________
ls -la ~/.android/avd/${ANDROID_AVD_NAME}.avd
echo ________
#LOOP_DEVICE=$(sudo losetup -f)
#sudo losetup ${LOOP_DEVICE} ~/.android/avd/${ANDROID_AVD_NAME}.avd/sdcard.img
mkdir ./sdcard
#sudo mount ${LOOP_DEVICE} ./sdcard
sudo mount -o loop,rw ~/.android/avd/${ANDROID_AVD_NAME}.avd/sdcard.img ./sdcard
cp ./app ./sdcard
sudo touch ./sdcard/coucou
ls -la ./sdcard
sudo umount ./sdcard
rmdir ./sdcard
#sudo losetup -d ${LOOP_DEVICE}
echo ________
${ANDROID_EMULATOR} -avd ${ANDROID_AVD_NAME} -no-window -no-audio -no-snapshot &
echo ________
${ANDROID_ADB} wait-for-device
${ANDROID_ADB} devices
${ANDROID_ADB} shell ls -la
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
