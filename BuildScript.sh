#!/bin/sh

#  BuildScript.sh
#  Bomapp
#
#  Created by ByoungHoon Yun on 25/09/2019.
#  Copyright © 2019 Redvelvet Ventures Inc. All rights reserved.

target_plist="./{PROJECT_NAME}/Info.plist"
buildDay=$(/usr/libexec/PlistBuddy -c "Print buildDay" "$target_plist")
buildCount=$(/usr/libexec/PlistBuddy -c "Print buildCount" "$target_plist")
today=$(date +%Y%m%d_%H%M)

if [ x"$buildDay" == x ]; then
buildDay=${today}
buildCount=1
printf -v zeroPadBuildCount '%03d' $buildCount
buildNumber=${buildDay}${zeroPadBuildCount}

/usr/libexec/PlistBuddy -c "Add :buildDay string $buildDay" "$target_plist"
/usr/libexec/PlistBuddy -c "Add :buildCount string $buildCount" "$target_plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$target_plist"

elif [ "$buildDay" != $today ]; then
buildDay=${today}
buildCount=1
printf -v zeroPadBuildCount '%03d' $buildCount
buildNumber=${buildDay}${zeroPadBuildCount}
/usr/libexec/PlistBuddy -c "Set :buildDay $buildDay" "$target_plist"
/usr/libexec/PlistBuddy -c "Set :buildCount $buildCount" "$target_plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$target_plist"

else
buildCount=$(($buildCount + 1))
printf -v zeroPadBuildCount '%03d' $buildCount
buildNumber=${buildDay}${zeroPadBuildCount}

/usr/libexec/PlistBuddy -c "Set :buildDay $buildDay" "$target_plist"
/usr/libexec/PlistBuddy -c "Set :buildCount $buildCount" "$target_plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$target_plist"

fi
