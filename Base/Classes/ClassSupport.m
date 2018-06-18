//
//  ClassSupport.m
//  Base
//
//  Created by poniavit on 18/6/2561 BE.
//

#import "ClassSupport.h"

@implementation ClassSupport : NSObject

+ (Class)swiftClassFromString:(NSString *)className {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *classStringName = [NSString stringWithFormat:@"_TtC%d%@%d%@", (int)appName.length, appName, (int)className.length, className];
    return NSClassFromString(classStringName);
}
    
@end
