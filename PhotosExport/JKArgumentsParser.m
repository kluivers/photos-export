//
//  JKArgumentsParser.m
//  PhotosExport
//
//  Created by Joris Kluivers on 08/11/2016.
//  Copyright © 2016 Joris Kluivers. All rights reserved.
//

#import "JKArgumentsParser.h"

#import "JKPrint.h"

@implementation JKArgumentsParser {
    NSDictionary<NSString *, NSString *> *_namedArguments;
}

- (id)initWithArguments:(const char **)arguments count:(int)count {
    self = [super init];
    
    if (self) {
        [self parseArguments:arguments count:count];
    }
    
    return self;
}

- (void) parseArguments:(const char **)arguments count:(int)count {
    NSMutableDictionary<NSString *, NSString *> *named = [@{} mutableCopy];
    NSMutableArray<NSString *> *args = [@[] mutableCopy];
    
    NSString *currentArg = nil;
    
    for (int i=0; i<count; i++) {
        NSString *arg = [NSString stringWithUTF8String:arguments[i]];
        
        if (currentArg) {
            named[currentArg] = arg;
            currentArg = nil;
            continue;
        }
        
        if ([arg hasPrefix:@"--"]) {
            currentArg = [arg substringFromIndex:2];
            continue;
        }
        
        [args addObject:arg];
    }
    
    _namedArguments = named;
}

- (NSString * _Nullable)valueForArgument:(NSString * _Nonnull)name {
    return [self valueForArgument:name withDefault:nil];
}

- (NSString * _Nullable)valueForArgument:(NSString * _Nonnull)name withDefault:(NSString * _Nullable)defaultValue {
    return _namedArguments[name] ?: defaultValue;
}

@end
