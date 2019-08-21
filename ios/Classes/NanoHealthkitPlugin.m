#import "NanoHealthkitPlugin.h"
#import <nano_healthkit_plugin/nano_healthkit_plugin-Swift.h>

@implementation NanoHealthkitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNanoHealthkitPlugin registerWithRegistrar:registrar];
}
@end
