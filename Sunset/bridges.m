#import "bridges.h"

static void reconfigurationCallback(
    CGDirectDisplayID display, CGDisplayChangeSummaryFlags flags, void *observer
) {
    ((__bridge void (^)(CGDirectDisplayID, CGDisplayChangeSummaryFlags))observer)(display, flags);
}

void CGDisplayRegisterReconfigurationCallback_Swift(void (^observer)(CGDirectDisplayID, CGDisplayChangeSummaryFlags)) {
    void *obsp = (__bridge_retained void *)observer;
    CGDisplayRegisterReconfigurationCallback(reconfigurationCallback, obsp);
}

#pragma mark -

bool ColorSyncIterateDeviceProfiles_Callback(CFDictionaryRef info, void *iterator) {
    return ((__bridge bool (^)(CFDictionaryRef info))iterator)(info);
}

void ColorSyncIterateDeviceProfiles_Swift(bool (^iterator)(NSDictionary *)) {
    ColorSyncIterateDeviceProfiles(ColorSyncIterateDeviceProfiles_Callback, (__bridge void *)iterator);
}