//
//  JKArgumentsParser.h
//  PhotosExport
//
//  Created by Joris Kluivers on 08/11/2016.
//  Copyright © 2016 Joris Kluivers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKArgumentsParser : NSObject

- (instancetype _Nonnull)initWithArguments:(const char * _Nonnull * _Nonnull)arguments count:(int)count;

- (NSString * _Nullable)valueForArgument:(NSString * _Nonnull)name;
- (NSString * _Nullable)valueForArgument:(NSString * _Nonnull)name withDefault:(NSString * _Nullable)defaultValue;

@end
