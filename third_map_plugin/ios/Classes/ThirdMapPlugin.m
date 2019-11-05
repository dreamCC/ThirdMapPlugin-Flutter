#import "ThirdMapPlugin.h"
#import <third_map_plugin/third_map_plugin-Swift.h>

@implementation ThirdMapPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftThirdMapPlugin registerWithRegistrar:registrar];
}
@end
