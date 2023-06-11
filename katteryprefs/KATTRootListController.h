#import <Preferences/PSListController.h>
#import <CepheiPrefs/CepheiPrefs.h>
#import <Cephei/HBPreferences.h>
#include "spawn.h"
#include "rootless.h"

@interface KATTRootListController : PSListController

@end

@interface NSTask : NSObject
@property (copy) NSArray *arguments;
@property (copy) NSString *launchPath;
- (id)init;
- (void)waitUntilExit;
- (void)launch;
@end