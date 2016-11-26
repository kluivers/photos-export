//
//  JKWorkflow.m
//  PhotosExport
//
//  Created by Joris Kluivers on 06/11/2016.
//  Copyright © 2016 Joris Kluivers. All rights reserved.
//

#import "JKWorkflow.h"

#import "JKPrint.h"

#import <ScriptingBridge/ScriptingBridge.h>

#import "Photos.h"

@implementation JKWorkflow {
    NSDateFormatter *_jsonDate;
}

- (id)init {
    self = [super init];
    
    if (self) {
        _jsonDate = [[NSDateFormatter alloc] init];
        [_jsonDate setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    }
    
    return self;
}

- (void)run {
    JKPrint(@"Album: %@", self.albumName);
    
    PhotosApplication *photos = [SBApplication applicationWithBundleIdentifier:@"com.apple.Photos"];
    
    NSArray<PhotosMediaItem *> *mediaItems = nil;
    if (self.albumName) {
        PhotosAlbum *album = [photos.albums objectWithName:self.albumName];
        if (!album) {
            JKPrint(@"Album not found");
            return;
        }
        
        mediaItems = album.mediaItems;
    } else {
        if ([photos.selection count] < 1) {
            JKPrint(@"No photos selected");
            return;
        }
        
        mediaItems = photos.selection;
    }
    
    JKPrint(@"%d items selected", [mediaItems count]);
    
    NSError *error = nil;
    NSURL *tmpURL = [self tmpDirectoryURL];
    [[NSFileManager defaultManager] createDirectoryAtURL:tmpURL withIntermediateDirectories:NO attributes:nil error:&error];
    
    [photos export:mediaItems to:tmpURL usingOriginals:NO];
    
    NSMutableArray *posts = [@[] mutableCopy];
    
    for (PhotosMediaItem *item in mediaItems) {
        NSString *name = [item.filename stringByDeletingPathExtension];
        NSString *type = [item.filename pathExtension];
        
        NSDictionary *itemMeta = @{
            @"name": name,
            @"type": type,
            @"description": item.objectDescription ?: @"",
            @"keywords": item.keywords ?: @[],
            @"date": [_jsonDate stringFromDate:item.date]
        };
        
        [posts addObject:itemMeta];
    }
    
    NSDictionary *indexJSON = @{@"posts": posts};
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:indexJSON options:0 error:&error];
    [data writeToURL:[tmpURL URLByAppendingPathComponent:@"index.json"] atomically:NO];
    
    JKPrint(@"Export directory: %@", [tmpURL path]);
}

- (NSURL *)tmpDirectoryURL {
    NSString *uuid = [[NSUUID UUID] UUIDString];
    
    return [[NSURL fileURLWithPath:@"/tmp"] URLByAppendingPathComponent:uuid];
}

@end
