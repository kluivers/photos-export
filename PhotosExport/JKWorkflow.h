//
//  JKWorkflow.h
//  PhotosExport
//
//  Created by Joris Kluivers on 06/11/2016.
//  Copyright © 2016 Joris Kluivers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKWorkflow : NSObject

@property(nonatomic, strong) NSString *albumName;

- (void)run;

@end
