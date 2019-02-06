# DarkSidebar

DarkSidebar is a plugin for Finder to use a dark sidebar while the overall appearance is set to light on macOS Mojave.

![Screenshot](screenshot.png)

### Getting started
* System Integrity Protection must be disabled in order for this to work.
* The user-wide appearance in Preferences must be set to light.
  * To obtain a dark menu-bar, set the appearance in Preferences to dark and then use the `NSRequiresAquaSystemAppearanc
e` defaults key globally or just for Finder using
```
defaults write -g NSRequiresAquaSystemAppearance -bool true
```
or
```
defaults write com.apple.Finder NSRequiresAquaSystemAppearance -bool true
```
* Use the following commands to restart Finder with the plugin:
```
osascript -e 'tell app "Finder" to quit'
DYLD_INSERT_LIBRARIES=libDarkSidebar.dylib /System/Library/CoreServices/Finder.app/Contents/MacOS/Finder
```

### Run at launch
* Move libDarkSidebar.dylib to /Library
* Edit /System/Library/LaunchAgents/com.apple.Finder.plist, replace
```
<key>Program</key>
<string>/System/Library/CoreServices/Finder.app/Contents/MacOS/Finder</string>
```
with
```
<array>
  <string>sh</string>
  <string>-c</string>
  <string>DYLD_INSERT_LIBRARIES=/Library/libDarkSidebar.dylib /System/Library/CoreServices/Finder.app/Contents/MacOS/Finder</string>
</array>
```

### How it works
Cocoa apps can choose to ignore the user appearance [by setting the `appearance` property of `NSApp` or of a specific view][1]. This makes it very easy to change the appearance of an app or of a specific part of an app window after hooking into it.

Setting the Finder sidebar appearance is just one of the few possibilities. One might set the appearance of a part of another app, set the appearance of just the title bar, or change the appearance of an entire app overriding the appearance set in Preferences by hooking into the `applicationDidFinishLaunchingWithOptions:` method of the application delegate.

[1]: https://developer.apple.com/documentation/appkit/nsappearancecustomization/choosing_a_specific_appearance_for_your_app
