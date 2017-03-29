#ifndef Sunset_bridges_h
#define Sunset_bridges_h

#import <CoreGraphics/CoreGraphics.h>

void CGDisplayRegisterReconfigurationCallback_Swift(void (^)(CGDirectDisplayID, CGDisplayChangeSummaryFlags));

#import <ApplicationServices/ApplicationServices.h>

void ColorSyncIterateDeviceProfiles_Swift(bool (^)(NSDictionary *));

#endif
