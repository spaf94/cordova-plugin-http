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
    NSString* str_connect_timeout = [command.arguments objectAtIndex:0];
    NSString* str_read_timeout = [command.arguments objectAtIndex:1];
    NSInteger connect_timeout = [str_connect_timeout intValue];
    NSInteger read_timeout = [str_read_timeout intValue];

    if (connect_timeout >= 0 && read_timeout >= 0) {
    	connectTimeout = connect_timeout;
        readTimeout = read_timeout;

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
