/********* SFHttpPlugin.m Cordova Plugin Implementation *******/

#import "SFHttpPlugin.h"

@implementation SFHttpPlugin

NSString *baseAddress = @"";
NSInteger *connectTimeout = 0;
NSInteger *readTimeout = 0;

- (void)setBaseAddress:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* base_Address = [command.arguments objectAtIndex:0];

    if (base_Address != nil && [base_Address length] > 0) {
    	baseAddress = base_Address;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:baseAddress];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setTimeouts:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* base_Address = [command.arguments objectAtIndex:0];

    if (base_Address != nil && [base_Address length] > 0) {
    	baseAddress = base_Address;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:baseAddress];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
