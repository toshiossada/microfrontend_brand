#import "ResponsysPlugin.h"
#if __has_include(<responsys/responsys-Swift.h>)
#import <responsys/responsys-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "responsys-Swift.h"
#endif

@implementation ResponsysPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftResponsysPlugin registerWithRegistrar:registrar];
}
@end
