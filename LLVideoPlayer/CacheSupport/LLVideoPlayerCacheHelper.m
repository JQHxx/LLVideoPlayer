//
//  LLVideoPlayerCacheHelper.m
//  Pods
//
//  Created by mario on 2017/6/28.
//
//

#import "LLVideoPlayerCacheHelper.h"
#import "LLVideoPlayerCacheFile.h"
#import "LLVideoPlayerDownloader.h"
#import "NSString+LLVideoPlayer.h"

@implementation LLVideoPlayerCacheHelper

+ (void)clearAllCache
{
    NSString *dir;
    
    dir = [LLVideoPlayerCacheFile cacheDirectory];
    [[NSFileManager defaultManager] removeItemAtPath:dir error:nil];
    
    dir = [LLVideoPlayerDownloader cacheDirectory];
    [[NSFileManager defaultManager] removeItemAtPath:dir error:nil];
}

+ (void)removeCacheForURL:(NSURL *)url
{
    {
        NSString *dir = [LLVideoPlayerCacheFile cacheDirectory];
        NSString *md5 = [url.absoluteString ll_md5];
        NSString *data = [dir stringByAppendingPathComponent:md5];
        NSString *index = [NSString stringWithFormat:@"%@%@", data, [LLVideoPlayerCacheFile indexFileExtension]];
        
        [[NSFileManager defaultManager] removeItemAtPath:data error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:index error:nil];
    }
    
    {
        NSString *dir = [LLVideoPlayerDownloader cacheDirectory];
        NSString *md5 = [url.absoluteString ll_md5];
        NSString *data = [dir stringByAppendingPathComponent:md5];
        NSString *index = [NSString stringWithFormat:@"%@%@", data, [LLVideoPlayerDownloadFile indexFileExtension]];
        
        [[NSFileManager defaultManager] removeItemAtPath:data error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:index error:nil];
    }
}

+ (void)preloadWithURL:(NSURL *)url
{
    [[LLVideoPlayerDownloader defaultDownloader] preloadWithURL:url bytes:2];
}

+ (void)preloadWithURL:(NSURL *)url bytes:(NSUInteger)bytes
{
    [[LLVideoPlayerDownloader defaultDownloader] preloadWithURL:url bytes:bytes];
}

+ (void)cancelWithURL:(NSURL *)url
{
    [[LLVideoPlayerDownloader defaultDownloader] cancelWithURL:url];
}

+ (void)cancelAllPreloads
{
    [[LLVideoPlayerDownloader defaultDownloader] cancelAllPreloads];
}

+ (BOOL)isCacheComplete:(NSURL *)url
{
    if (nil == url) {
        return NO;
    }
    if ([url isFileURL]) {
        return YES;
    }
    NSString *name = [url.absoluteString ll_md5];
    NSString *path = [[LLVideoPlayerCacheFile cacheDirectory] stringByAppendingPathComponent:name];
    LLVideoPlayerCacheFile *cacheFile = [LLVideoPlayerCacheFile cacheFileWithFilePath:path cachePolicy:nil];
    return [cacheFile isComplete];
}

@end

@implementation LLVideoPlayerCacheHelper (CacheDirectory)

+ (NSString *)cacheDirectory
{
    return [LLVideoPlayerCacheFile cacheDirectory];
}

+ (NSString *)preloadCacheDirectory
{
    return [LLVideoPlayerDownloader cacheDirectory];
}

@end
