#!/bin/bash

# Remove all bloatware from Huawei device
function removeAllApps() {

    USER_NUM="0"

    # Thanks to SilviuO for putting together this guide https://forum.xda-developers.com/huawei-p30-pro/how-to/how-to-remove-huawei-bloatware-vog-ele-t4014937
    # The majority of this app list and the descriptions are derived from that guide

    huaweiApps=(
        "com.baidu.input_huawei"              # Huawei chinese stock input keyboard
        "com.huawei.appmarket"                # Huawei Market app
        "com.huawei.android.chr"              # HwChrService
        "com.huawei.android.FloatTasks"       # Floating dock function
        "com.huawei.android.hsf"              # Huawei Services Framework
        "com.huawei.android.hwpay"            # Huawei Pay
        "com.huawei.android.karaoke"          # Karaoke mode
        "com.huawei.android.mirrorshare"      # MirrorShare
        "com.huawei.android.remotecontroller" # Huawei Smart Controller app
        "com.huawei.search"                   # HiSearch
        "com.huawei.stylus.floatmenu"         # Floating menu with M-Pen feature
        "com.huawei.android.tips"             # Huawei Tips app
        "com.huawei.android.totemweather"     # Huawei Weather app
        "com.huawei.browser"                  # Huawei Browser app
        "com.huawei.contactscamcard"          # CamCard is a business card reader app
        "com.huawei.compass"                  # Huawei Compass app
        "com.huawei.gameassistant"            # Huawei Game Suite (HiGame)
        "com.huawei.hdiw"                     # Huawei ID app
        "com.huawei.hidisk"                   # Huawei File Manager app
        "com.huawei.hifolder"                 # Huawei Online Cloud folder service
        "com.huawei.himovie.overseas"         # Huawei videos app
        "com.huawei.hitouch"                  # Floating dock by Huawei
        "com.huawei.hwdetectrepair"           # Sliding screen feature
        "com.huawei.ihealth"                  # MotionService package, it's required for actions like shaking the phone to shut off the alarm
        "com.huawei.health"                   # Huawei Health app
        "com.huawei.hicloud"                  # Huawei cloud services
        "com.huawei.livewallpaper.paradise"   # Live wallpaper service
        "com.huawei.pcassistant"              # HiSuite service
        "com.huawei.phoneservice"             # HiCare app
        "com.huawei.mirror"                   # Huawei Mirror app
        "com.android.hwmirror"                # Huawei Mirror app with a different name
        "com.huawei.screenrecorder"           # Huawei Screen recorder feature
        "com.huawei.vassistant"               # HiVoice app
        "com.huawei.videoeditor"              # Video editor function
        "com.huawei.wallet"                   # Huawei Wallet app
        "com.huawei.watch.sync"               # Huawei Watch sync function
        "com.huawei.android.hwupgradeguide"   # Huawei upgrade guide
        "com.huawei.HwMultiScreenShot"        # HW Flashlist app
        "com.example.android.notepad"         # Default Huawei Notepad app
        "com.hicloud.android.clone"           # Huawei phone clone app
        "com.android.deskclock"               # default clock app
    )

    carrierApps=(
        "ca.bellmedia.cravetv"                  # Bell media CraveTV app
        "com.quickplay.android.bellmediaplayer" # FibeTV app
        "ca.bell.wt.android.tunesappswidget"    # Bell widget that comes with the CraveTV and Fibe apps
    )

    facebookApps=(
        "com.facebook.appmanager"
        "com.facebook.system"
        "com.facebook.katana"
        "com.facebook.services"
    )

    googleApps=(
        "com.google.android.googlequicksearchbox"     # Google Assistant
        "com.google.android.apps.books"               # Google Books
        "com.google.android.apps.docs.editors.docs"   # Google Docs
        "com.google.android.apps.docs.editors.sheets" # Google Sheets
        "com.google.android.apps.docs.editors.slides" # Google Slides
        "com.google.android.apps.cloudprint"          # Cloud print
        "com.google.android.apps.docs"                # Google Drive
        "com.google.android.apps.mapps"               # Google Maps app
        "com.google.android.apps.photos"              # Google Photos
        "com.google.android.apps.tachyon"             # Google Duo
        "com.google.android.apps.magazines"           # Google News
        "com.google.android.feedback"                 # Google Feedback
        "com.google.android.keep"                     # Google Keep
        "com.google.android.marvin.talkback"          # Android Accessibility Suite
        "com.google.android.music"                    # Google Music
        "com.google.android.play.games"               # Google Play Games app
        "com.google.android.projection.gearhead"      # Android Auto
        "com.google.android.talk"                     # Hangouts
        "com.google.android.videos"                   # Google Play Movies
        "com.google.android.youtube"                  # Youtube
        "com.google.android.apps.youtube.music"       # YouTube Music
        "com.google.android.googlequicksearchbox"     # Google Search
    )

    miscApps=(
        "com.amazon.appmanager"             # Amazon app
        "com.amazon.mShop.android.shopping" # Amazon app related
        "com.booking"                       # Booking app
        "com.android.calendar"              # Default calendar app
        "com.android.chrome"                # Chrome Browser
    )

    failures=0
    successes=0

    function checkExists() {
        local FAIL_STATE="not installed"
        local status="$*"
        if echo "$status" | grep -q "$FAIL_STATE"; then
            ((failures++))
        else
            ((successes++))
        fi
    }

    function uninstallApp() {
        checkExists $(./adb uninstall --user $USER_NUM $1)
    }

    function uninstallList() {
        for a in "$@"; do
            echo "Uninstalling $a"
            uninstallApp $a
        done

    }

    uninstallList "${huaweiApps[@]}"
    uninstallList "${carrierApps[@]}"
    uninstallList "${facebookApps[@]}"
    uninstallList "${miscApps[@]}"

    # I left this commented out, simply because a lot of people actually use Google's apps
    #uninstallList "${googleApps[@]}"

}

if ! command -v adb &>/dev/null; then
    echo "Please make sure adb is executable from the current directory." &>2
    exit
fi

removeAllApps

echo "Already absent apps: $failures"
echo "Successful uninstalls: $successes"

echo "Done"
