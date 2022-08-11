#import "ProximityScreenLockIosPlugin.h"
#if __has_include(<proximity_screen_lock_ios/proximity_screen_lock_ios-Swift.h>)
#import <proximity_screen_lock_ios/proximity_screen_lock_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "proximity_screen_lock_ios-Swift.h"
#endif

@implementation ProximityScreenLockIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftProximityScreenLockIosPlugin registerWithRegistrar:registrar];
}
@end
