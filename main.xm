// casper toggle com.foxfort.deluminatorsettings on && casper refresh com.foxfort.deluminatorsettings/settingschanged
// casper toggle com.foxfort.facebookdarkmodesettings on && casper refresh com.foxfort.facebookdarkmodesettings/settingschanged
// casper toggle com.creaturecoding.touchflow on && casper refresh com.creaturecoding.touchflow.prefschanged

#include <stdio.h>
#include <unistd.h>
#include <Foundation/Foundation.h>

#import <objc/runtime.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreFoundation/CFNotificationCenter.h>

extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter();

void usage()
{
	printf("casper is a CLI tool that lets you toggle tweak preferences on or off and applying the changes without respringing.\n");
	printf("\n");
	printf("Usage:\n");
	printf("casper toggle <preferencefile> <on|off>\n");
	printf("casper refresh <darwinNotification>\n");
	printf("\n");
	printf("Example: \n");
	printf("# Toggle MobileGoose on\n");
	printf("casper toggle com.pixelomer.mobilegoose on && casper refresh com.pixelomer.mobilegoose/PreferenceChange\n");
}

int main(int argc, char *argv[], char *envp[]) {

	if (argc < 2) {
		usage();
		return 0;
	}

	if ([[NSString stringWithUTF8String:argv[1]] compare:@"help" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
		usage();
		return 0;
	}

	if ([[NSString stringWithUTF8String:argv[1]] compare:@"-h" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
		usage();
		return 0;
	}

	if ([[NSString stringWithUTF8String:argv[1]] compare:@"--help" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
		usage();
		return 0;
	}

	if ([[NSString stringWithUTF8String:argv[1]] compare:@"toggle" options:NSCaseInsensitiveSearch] == NSOrderedSame) {

		CFPropertyListRef valueTrue  = (__bridge CFPropertyListRef)[NSNumber numberWithBool:1];
		CFPropertyListRef valueFalse = (__bridge CFPropertyListRef)[NSNumber numberWithBool:0];

		CFStringRef app = CFStringCreateWithCString(NULL, argv[2], kCFStringEncodingUTF8);

		if ([[NSString stringWithUTF8String:argv[3]] compare:@"on" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
			CFPreferencesAppSynchronize(app);
			CFPreferencesSetAppValue((__bridge CFStringRef)@"Enabled", valueTrue, app);
			CFPreferencesSetAppValue((__bridge CFStringRef)@"enabled", valueTrue, app);
			CFPreferencesAppSynchronize(app);
			printf("%s ON\n", argv[2]);
		} else if ([[NSString stringWithUTF8String:argv[3]] compare:@"off" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
			CFPreferencesAppSynchronize(app);
			CFPreferencesSetAppValue((__bridge CFStringRef)@"Enabled", valueFalse, app);
			CFPreferencesSetAppValue((__bridge CFStringRef)@"enabled", valueFalse, app);
			CFPreferencesAppSynchronize(app);
			printf("%s OFF\n", argv[2]);
		}

		return 0;
	}

	if ([[NSString stringWithUTF8String:argv[1]] compare:@"refresh" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
		CFNotificationCenterRef center = CFNotificationCenterGetDarwinNotifyCenter();
		CFStringRef str = CFStringCreateWithCString(NULL, argv[2], kCFStringEncodingUTF8);
		CFNotificationCenterPostNotification(center, str, NULL, NULL, YES);
		printf("Refreshing %s…\n", argv[2]);
		return 0;
	}

	if ([[NSString stringWithUTF8String:argv[1]] compare:@"refreshd" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
		CFNotificationCenterRef center = CFNotificationCenterGetDistributedCenter();
		CFStringRef str = CFStringCreateWithCString(NULL, argv[2], kCFStringEncodingUTF8);
		CFNotificationCenterPostNotification(center, str, NULL, NULL, YES);
		printf("Refreshing %s…\n", argv[2]);
		return 0;
	}

	return 0;
}