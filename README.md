# Casper
casper is a CLI tool that lets you toggle tweak preferences on or off and applying the changes without respringing.

## Disclaimer and bugs
I'm an absolute dick in Objective-C/Objective-C++, I just read some docs and some open source projects and tried whipping out this useful monstruosity that barely works.
- It won't work if you run as root, run as mobile. Why? I dunno.
- `refresh` sends a notification to the Darwin notification center
- `refreshd` sends it to the distributed notification center
- What's the difference? ¯\\\_(ツ)\_/¯

## Usage
```
casper is a CLI tool that lets you toggle tweak preferences on or off and applying the changes without respringing.

Usage:
casper toggle <preferencefile> <on|off>
casper refresh <darwinNotification>

Examples:
# Toggle MobileGoose on
casper toggle com.pixelomer.mobilegoose on && casper refresh com.pixelomer.mobilegoose/PreferenceChange

```