//
//  JKPrint.m
//  PhotosExport
//
//  Created by Joris Kluivers on 08/11/2016.
//  Copyright © 2016 Joris Kluivers. All rights reserved.
//

#import "JKPrint.h"

void JKPrint(NSString *format, ...) {
    va_list va;
    va_start(va, format);
    
    NSError *error = nil;
    
    NSString *str = [[NSString alloc] initWithFormat:format arguments:va];
    
    [str writeToFile:@"/dev/stdout" atomically:NO encoding:NSUTF8StringEncoding error:&error];
    [@"\n" writeToFile:@"/dev/stdout" atomically:NO encoding:NSUTF8StringEncoding error:&error];
    
    va_end(va);
}
