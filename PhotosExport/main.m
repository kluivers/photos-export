//
//  main.m
//  PhotosExport
//
//  Created by Joris Kluivers on 06/11/2016.
//  Copyright © 2016 Joris Kluivers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ScriptingBridge/ScriptingBridge.h>

#import "JKArgumentsParser.h"
#import "JKWorkflow.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        JKArgumentsParser *parser = [[JKArgumentsParser alloc] initWithArguments:argv count:argc];
        
        JKWorkflow *workflow = [[JKWorkflow alloc] init];
        workflow.albumName = [parser valueForArgument:@"album" withDefault:nil];
        
        [workflow run];
    }
    return 0;
}
