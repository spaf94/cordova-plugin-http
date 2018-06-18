/********* SFHttpPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface SFHttpPlugin : CDVPlugin 

- (void)setBaseAddress:(CDVInvokedUrlCommand*)command;
- (void)setTimeouts:(CDVInvokedUrlCommand*)command;
- (void)sendGet:(CDVInvokedUrlCommand*)command;
- (void)sendPost:(CDVInvokedUrlCommand*)command;

extern NSString *baseAddress;
extern NSInteger *connectTimeout;
extern NSInteger *readTimeout;

@end
