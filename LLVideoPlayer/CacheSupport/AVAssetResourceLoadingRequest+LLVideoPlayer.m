//
//  AVAssetResourceLoadingRequest+LLVideoPlayer.m
//  Pods
//
//  Created by mario on 2017/2/23.
//
//

#import "AVAssetResourceLoadingRequest+LLVideoPlayer.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NSHTTPURLResponse+LLVideoPlayer.h"
#import "LLVideoPlayerInternal.h"

@implementation AVAssetResourceLoadingRequest (LLVideoPlayer)

- (void)ll_fillContentInformation:(NSURLResponse *)response
{
    LLLog(@"ll_fillContentInformation");
    
    if (nil == response) {
        return;
    }
    
    self.response = response;
    
    if (nil == self.contentInformationRequest) {
        return;
    }
    
    NSString *mimeType = [response MIMEType];
    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)(mimeType), NULL);
    self.contentInformationRequest.contentType = CFBridgingRelease(contentType);
    
    if (NO == [response isKindOfClass:[NSHTTPURLResponse class]]) {
        return;
    }
    
    self.contentInformationRequest.byteRangeAccessSupported = [(NSHTTPURLResponse *)response ll_supportRange];
    self.contentInformationRequest.contentLength = [(NSHTTPURLResponse *)response ll_totalLength];
}

@end
