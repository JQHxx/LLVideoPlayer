//
//  LLVideoPlayerCacheFile.h
//  Pods
//
//  Created by mario on 2017/2/23.
//
//

#import <Foundation/Foundation.h>
#import "LLVideoPlayerCachePolicy.h"

typedef NS_ENUM(NSInteger, LLCacheFileSaveFlags) {
    LLCacheFileSaveFlagsNone,
    LLCacheFileSaveFlagsSync,
};

@interface LLVideoPlayerCacheFile : NSObject

@property (nonatomic, strong) NSDictionary *responseHeaders;
@property (nonatomic, assign, readonly) NSUInteger fileLength;

+ (instancetype)cacheFileWithFilePath:(NSString *)filePath cachePolicy:(LLVideoPlayerCachePolicy *)cachePolicy;

- (instancetype)initWithFilePath:(NSString *)filePath cachePolicy:(LLVideoPlayerCachePolicy *)cachePolicy;

- (BOOL)saveData:(NSData *)data offset:(NSUInteger)offset flags:(LLCacheFileSaveFlags)flags;

- (NSData *)dataWithRange:(NSRange)range;

- (NSRange)firstNotCachedRangeFromPosition:(NSUInteger)position;

- (void)removeCache;

- (BOOL)setResponse:(NSHTTPURLResponse *)response;

- (NSUInteger)maxCachedLength;

- (BOOL)synchronize;

+ (NSString *)cacheDirectory;

@end
