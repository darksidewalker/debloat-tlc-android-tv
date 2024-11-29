#!/bin/bash

# Check if IP address is provided as a parameter
if [ -z "$1" ]; then
    echo "Error: No IP address provided."
    echo "Usage: ./debloat.sh <TV_IP_ADDRESS>"
    exit 1
fi

TV_IP="$1"
ADB_PORT=5555

# Connect to ADB over the network
echo "Connecting to TV at IP address: $TV_IP..."
adb connect "$TV_IP:$ADB_PORT"

# Check if the connection was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to connect to TV at IP address: $TV_IP"
    exit 1
fi

echo "Successfully connected to TV at IP: $TV_IP."

# Bloatware list - safe to remove apps
bloat=()

# TCL Bloatware
bloat+=("com.tcl.partnercustomizer") # TCL partner customization app
bloat+=("com.tcl.gallery") # Gallery app
bloat+=("com.tcl.notereminder") # Notes and reminders app
bloat+=("com.tcl.ui_mediaCenter") # USB File explorer app
bloat+=("com.tcl.guard") # Antivirus app
bloat+=("com.tcl.tvweishi") # Homescreen service for antivirus
bloat+=("com.tcl.tv.tclhome_master") # TCL home master service
bloat+=("com.tcl.copydatatotv") # Data transfer service
bloat+=("com.tcl.initsetup") # Initial setup app
bloat+=("com.tcl.usercenter") # User account management
bloat+=("com.tcl.externaldevice.update") # External device update service
bloat+=("com.tcl.useragreement") # User agreement service
bloat+=("com.tcl.appstatecontroller") # App state controller
bloat+=("com.tcl.videoplayer") # Video player app
bloat+=("com.tcl.pvr.pvrplayer") # PVR player app
bloat+=("com.tcl.assistant") # TCL assistant app
bloat+=("com.tcl.ext.services") # External services
bloat+=("com.tcl.bootadservice") # Ads within TCL apps
bloat+=("com.tcl.esticker") # Sticker app
bloat+=("com.tcl.bi") # Business intelligence app
bloat+=("com.tcl.xian.StartandroidService") # Start Android service
bloat+=("com.tcl.miracast") # Miracast service
bloat+=("com.tcl.imageplayer") # Image player app
bloat+=("com.tcl.rc.ota") # OTA update service for non-critical updates
bloat+=("com.tcl.airplay2") # Airplay service
bloat+=("com.tcl.waterfall.overseas") # TCL Channel App
bloat+=("com.tcl.channelplus") # TCL Channel App

# Freeview Apps (Could be useful for some users, but often considered bloat)
bloat+=("uk.co.freeview.mdsclient") # Freeview MDS client
bloat+=("uk.co.freeview.amc_catchup") # Freeview AMC catch-up
bloat+=("uk.co.freeview.onnow") # Freeview on now
bloat+=("uk.co.freeview.uktv") # Freeview UKTV
bloat+=("uk.co.freeview.fvpconfigauth") # Freeview FVP config auth
bloat+=("uk.co.freeview.systemdistributor") # Freeview system distributor
bloat+=("uk.co.freeview.tifbridge") # Freeview TIF bridge
bloat+=("uk.co.freeview.explore") # Freeview explore app
bloat+=("uk.co.freeview.bbc") # Freeview BBC app
bloat+=("uk.co.freeview.ch5") # Freeview Channel 5 app
bloat+=("uk.co.freeview.itv") # Freeview ITV app
bloat+=("uk.co.freeview.stv") # Freeview STV app
bloat+=("uk.co.freeview.amc_horror") # Freeview AMC horror
bloat+=("uk.co.freeview.ch4_vod") # Freeview Channel 4 VOD

# Other Non-Essential Apps
bloat+=("com.android.cts.priv.ctsshim") # CTS shim for testing
bloat+=("com.google.android.onetimeinitializer") # Google initializer
bloat+=("com.google.android.partnersetup") # Google setup service
bloat+=("com.google.android.feedback") # Google feedback service
bloat+=("com.google.android.syncadapters.calendar") # Calendar sync adapter

# Optional Apps (Based on User Preference)
bloat+=("com.google.android.youtube.tvmusic") # YouTube TV Music
bloat+=("com.google.android.tvrecommendations") # Google TV recommendations (can be intrusive)
bloat+=("com.google.android.marvin.talkback") # Talkback accessibility feature
bloat+=("com.google.android.play.games") # Google Play Games
bloat+=("com.netflix.ninja") # Netflix app
bloat+=("com.limelight") # Limelight app
bloat+=("tv.mopa.ginga") # Ginga app
bloat+=("com.mediatek.AirplayAPK") # Airplay service
bloat+=("tv.wuaki.apptv") # Rakuten TV

# Unwanted system apps that don’t affect core functions
bloat+=("com.android.providers.calendar")
bloat+=("com.android.providers.contacts")
bloat+=("com.android.providers.userdictionary")

# Just disable
# Optional: Include more TCL apps if you are sure they aren’t needed
dable+=("com.tcl.framework.custom") # TV UI elements
dable+=("com.tcl.tv") # Might be critical for TV operations, proceed with caution
dable+=("com.tcl.tvinput") # TV input service
dable+=("com.tcl.ocean.instructions") # TCL User-Manual App
dable+=("com.tcl.dashboard") # Dashboard service
dable+=("com.tcl.messagebox") # Message box service
dable+=("com.tcl.systemserver") # System server for TCL
dable+=("com.tcl.ttvs")
dable+=("com.tcl.providers.config") # Configuration provider
dable+=("com.tcl.tv.tclhome_passive") # TCL smart home component
dable+=("com.tcl.versionUpdateApp")

# Start debloating process
echo "Starting debloating process... Removing unwanted apps."

for package in "${bloat[@]}"; do
    echo "Removing package: $package..."
    adb shell pm uninstall --user 0 "$package" 
    if [ $? -eq 0 ]; then
        echo "Successfully removed: $package"
    else
        echo "Failed to remove: $package"
    fi
done

for package in "${dable[@]}"; do
    echo "Disabling package: $package..."
    adb shell pm disable-user --user 0 "$package" 
    if [ $? -eq 0 ]; then
        echo "Successfully disabled: $package"
    else
        echo "Failed to disable: $package"
    fi
done

# Reboot device to ensure changes take effect
echo "Rebooting TV to apply changes..."
adb reboot

echo "Debloating process completed successfully."
