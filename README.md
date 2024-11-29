# Debloat TCL Android TV

TCL Android TVs are great value, but they often come with a lot of pre-installed bloatware that can significantly affect performance. This script helps you remove unwanted apps (bloatware) to improve the TV's responsiveness.

> **⚠️ Warning Use at your own risk**. 

> Removing certain system apps may cause unexpected issues or make the TV unstable.  You are responsible for any issues caused by running this script.

---

## Prerequisites

Before using this script, ensure that you:
1. **Know how to use ADB**.  
   If you're unfamiliar with ADB, make sure you set it up and know how to use it.
2. **Have ADB installed** on your computer.  
   Ensure that your TV and PC are connected to the same Wi-Fi network.

---

## How to Use

1. **Clone the repository**:

	```bash
	git clone https://github.com/chrissy-dev/debloat-tlc-android-tv
	cd debloat-tlc-android-tv
	```

2. **Make the script executable**:

	```bash
	chmod +x debloat.sh
	```

3. **Run the script with the TV’s IP address as an argument**:

	```bash
	./debloat.sh <TV_IP_ADDRESS>
	```

4. **The script will connect to your TV, inform you about the process, and remove bloatware.**  

	It will also reboot the TV to apply the changes.

---

## What the Script Does

1. **Connects to the TV**:  
   The script uses ADB over the network, requiring the TV’s IP address. If no IP address is provided, the script will exit and show usage instructions.

2. **Informs the User**:  
   The script provides feedback on each step, such as connecting to the TV, removing apps, and rebooting the device.

3. **Uninstalls Bloatware**:  
   The script iterates through a list of predefined apps and removes them using ADB commands. For each app, the script will notify you whether it was successfully removed or failed.

4. **Disables some unwanted tcl system-software**:
   The script iterates through a list of predefined apps and diables them using ADB commands. For each app, the script will notify you whether it was successfully diabled or failed.

6. **Reboots the TV**:  
   After all apps are removed, the script reboots your TV to ensure that the changes take effect.

---

## Script Overview

### 1. **Check for ADB**  
   The script checks if ADB is installed on your system. If not, it exits and prompts you to install ADB.

### 2. **Connect to the TV**  
   The script uses the ADB `connect` command to establish a connection to the TV via its IP address.

### 3. **Debloating Process**  
   The script has a pre-defined list of TCL bloatware packages, including apps like:
   - `com.tcl.partnercustomizer`
   - `com.tcl.smartalexa`
   - `com.tcl.tvweishi`  
   ...and many more. These apps are removed one by one using the `adb shell pm uninstall` command.

### 4. **Reboot the TV**  
   Once all apps are removed, the TV is rebooted to ensure that all changes take effect.

---

## Optional Customisation

1. **Modify the App List**:  
   If you want to add or remove specific apps from the debloat list, open the script and modify the `bloat` array. Be cautious and ensure the apps you remove are not essential for TV operation.

2. **Include or Exclude Apps**:  
   You can comment or uncomment specific apps in the `bloat` array to either exclude them from removal or include additional unwanted apps.
   
### Table of apps audited

Running `adb shell cmd package list packages` will list all packages installed. This is the result of mine.

| **Package Name**                                  | **Description**                                  | **Safe to Remove?**      |
|---------------------------------------------------|--------------------------------------------------|-----------------|
| `com.android.cts.priv.ctsshim`                   | CTS private shim for compatibility testing.      | ⚠️ Caution     |
| `com.google.android.ext.services`                | Extended Google services.                        | ⚠️ Caution     |
| `com.google.android.apps.mediashell`             | MediaShell test framework.                       | ⚠️ Caution     |
| `com.google.android.katniss`                     | Google voice search.                             | ⚠️ Caution     |
| `com.tcl.esticker`                               | TCL eSticker service.                            | ✅ Safe         |
| `com.android.dynsystem`                          | Dynamic system updates.                          | ⚠️ Caution     |
| `uk.co.freeview.mdsclient`                       | Freeview MDS client.                             | ⚠️ Caution     |
| `com.tcl.initsetup`                              | TCL initial setup service.                       | ⚠️ Caution     |
| `com.android.providers.calendar`                 | Calendar content provider.                       | ⚠️ Caution     |
| `com.android.tv.settings`                        | Android TV settings.                             | ⚠️ Caution     |
| `com.tcl.tvinput`                                | TCL TV input service.                            | ✅ Safe         |
| `uk.co.freeview.amc_catchup`                     | AMC catch-up service for Freeview.               | ✅ Safe         |
| `com.android.providers.media`                    | Media provider for Android.                      | ❌ Critical     |
| `com.google.android.onetimeinitializer`          | Google one-time setup initializer.               | ⚠️ Caution     |
| `com.google.android.ext.shared`                  | Shared Google services.                          | ⚠️ Caution     |
| `com.plexapp.android`                            | Plex streaming app.                              | ✅ Safe         |
| `com.tcl.keyhelp`                                | TCL key help service for remote support.         | ✅ Safe         |
| `com.spocky.projengmenu`                         | TCL engineering menu for debugging.              | ✅ Safe         |
| `uk.co.freeview.onnow`                           | Freeview Play On Now application.                | ✅ Safe         |
| `com.tcl.factory.view`                           | TCL factory settings view.                       | ⚠️ Caution     |
| `au.com.stan.and`                                | Stan streaming service app.                      | ✅ Safe         |
| `com.android.externalstorage`                    | Manages external storage access.                 | ❌ Critical     |
| `uk.co.freeview.uktv`                            | UKTV app for Freeview Play.                      | ✅ Safe         |
| `com.android.htmlviewer`                         | Basic HTML viewer included with Android.         | ⚠️ Caution     |
| `com.tcl.pvr.pvrplayer`                          | TCL Personal Video Recorder player.              | ✅ Safe         |
| `com.android.companiondevicemanager`             | Manages pairing with companion devices.          | ⚠️ Caution     |
| `com.android.providers.downloads`                | Core downloads provider for Android.             | ❌ Critical     |
| `com.android.messaging`                          | Default Android messaging app.                   | ⚠️ Caution     |
| `com.android.providers.tv`                       | TV content provider for Android TV.              | ❌ Critical     |
| `com.android.networkstack.inprocess`             | Handles in-process network services.             | ❌ Critical     |
| `com.google.android.backdrop`                    | Backdrop (screensaver) app for Android TV.       | ⚠️ Caution     |
| `com.android.tv.settings.gms.resoverlay`         | Resource overlay for Android TV settings.        | ❌ Critical     |
| `com.tcl.useragreement`                          | TCL user agreement prompt app.                   | ✅ Safe         |
| `com.tcl.miracast`                               | TCL Miracast service for screen mirroring.       | ✅ Safe         |
| `com.google.android.tungsten.setupwraith`        | Android TV setup wizard.                         | ❌ Critical     |
| `com.tcl.gallery`                                | TCL gallery app for media viewing.               | ✅ Safe         |
| `com.google.android.overlay.modules.permissioncontroller` | Overlay for permissions.                 | ⚠️ Caution     |
| `com.android.vending`                            | Google Play Store.                               | ❌ Critical     |
| `com.android.pacprocessor`                       | Proxy Auto-Config (PAC) processor.               | ⚠️ Caution     |
| `uk.co.freeview.fvpconfigauth`                   | Freeview Play configuration/auth service.        | ⚠️ Caution     |
| `com.android.certinstaller`                      | Certificate installer for secure networks.       | ❌ Critical     |
| `com.google.android.marvin.talkback`             | Google TalkBack for accessibility.               | ✅ Safe         |
| `android`                                        | Core Android operating system package.           | ❌ Critical     |
| `com.android.camera2`                            | Default camera application.                      | ⚠️ Caution     |
| `ar.tvplayer.tv`                                 | Third-party TV streaming app.                    | ✅ Safe         |
| `uk.co.freeview.systemdistributor`               | Freeview system service for content distribution.| ⚠️ Caution     |
| `com.tcl.inputmethod.international`              | TCL international keyboard.                      | ⚠️ Caution     |
| `uk.co.freeview.bbc_sounds`                      | BBC Sounds app for Freeview Play.                | ✅ Safe         |
| `com.android.backupconfirm`                      | System backup confirmation dialog.               | ⚠️ Caution     |
| `com.tcl.xian.StartandroidService`               | TCL-specific startup service.                    | ⚠️ Caution     |
| `com.tvos`                                       | TCL TV operating system package.                 | ❌ Critical     |
| `com.tcl.system.server`                          | TCL system services manager.                     | ❌ Critical     |
| `com.tcl.guard`                                  | TCL security or monitoring service.              | ⚠️ Caution     |
| `com.android.statementservice`                   | Verifies app permissions and statements.         | ⚠️ Caution     |
| `com.tcl.tcl_bt_rcu_service`                     | Bluetooth remote control service for TCL TVs.    | ⚠️ Caution     |
| `com.android.settings.intelligence`              | Smart settings features for Android TV.          | ⚠️ Caution     |
| `com.google.android.permissioncontroller`        | Manages app permissions.                         | ❌ Critical     |
| `com.amazon.amazonvideo.livingroom`              | Amazon Prime Video app.                          | ✅ Safe         |
| `com.android.providers.settings`                 | Core settings provider for Android.              | ❌ Critical     |
| `com.tcl.versionUpdateApp`                       | TCL version update service.                      | ⚠️ Caution     |
| `com.android.sharedstoragebackup`                | Backup service for shared storage.               | ⚠️ Caution     |
| `uk.co.freeview.tifbridge`                       | Tuner Information Framework (TIF) for Freeview.  | ⚠️ Caution     |
| `com.tcl.waterfall.overseas`                     | TCL-specific waterfall UI service.               | ✅ Safe         |
| `com.android.printspooler`                       | System print service manager.                    | ⚠️ Caution     |
| `com.tcl.assistant`                              | TCL voice assistant service.                     | ✅ Safe         |
| `com.android.dreams.basic`                       | Basic screensaver (Daydream) service.            | ⚠️ Caution     |
| `com.tcl.t_solo`                                 | TCL-specific solo operation service.             | ⚠️ Caution     |
| `com.google.android.overlay.modules.ext.services`| Google system overlay service.                   | ⚠️ Caution     |
| `com.tcl.copydatatotv`                           | TCL data migration tool.                         | ✅ Safe         |
| `com.tcl.micmanager`                             | TCL microphone manager for remote or assistant.  | ⚠️ Caution     |
| `com.android.se`                                 | Secure Element services for NFC.                 | ⚠️ Caution     |
| `com.android.inputdevices`                       | Handles input devices like keyboards and remotes.| ⚠️ Caution     |
| `com.tcl.notereminder`                           | TCL note reminder application.                   | ✅ Safe         |
| `com.google.android.tvrecommendations`           | Recommendations for Android TV home screen.      | ⚠️ Caution     |
| `com.tcl.audioplayer`                            | TCL audio player application.                    | ✅ Safe         |
| `uk.co.freeview.explore`                         | Freeview Explore app.                            | ✅ Safe         |
| `com.tcl.MultiScreenInteraction_TV`              | TCL multiscreen interaction service.             | ⚠️ Caution     |
| `com.google.android.modulemetadata`              | Google module metadata.                          | ⚠️ Caution     |
| `com.google.android.tvlauncher`                  | Launcher for Android TV.                         | ⚠️ Caution     |
| `com.google.android.webview`                     | WebView implementation by Google.                | ⚠️ Caution     |
| `com.android.keychain`                           | Keychain service for secure credentials.         | ⚠️ Caution     |
| `com.google.android.youtube.tvmusic`             | YouTube Music for TV.  | ✅ Safe         |                         
 
---

## Troubleshooting

- **ADB Connection Issues**:  
  If you’re unable to connect to your TV, ensure that your TV’s IP address is correct and that ADB debugging is enabled in your TV’s settings.
  
- **Failed App Removals**:  
  If an app fails to remove, check the error message for more details. Some apps might be protected by the system, and removal could require advanced steps.

---

## Example Output

```bash
Connecting to TV at IP address: 192.168.1.100...
Successfully connected to TV at IP: 192.168.1.100.
Starting debloating process... Removing unwanted apps.
Removing package: com.tcl.partnercustomizer...
Successfully removed: com.tcl.partnercustomizer
Removing package: com.tcl.smartalexa...
Failed to remove: com.tcl.smartalexa
Rebooting TV to apply changes...
Debloating process completed successfully.
```

---

## License

Feel free to modify and share this script. However, use at your own risk! The script is provided "as-is" with no warranties or guarantees.
