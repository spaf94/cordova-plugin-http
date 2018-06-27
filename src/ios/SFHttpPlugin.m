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

- (void)sendGet:(CDVInvokedUrlCommand*)command
{
    NSString* endPoint = [command.arguments objectAtIndex:0];
    NSString* jsonHeaders = [command.arguments objectAtIndex:1];

    endPoint = [NSString stringWithFormat:@"%@%@", baseAddress, endPoint];

    NSData *data = [jsonHeaders dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id headers = [NSJSONSerialization
                    JSONObjectWithData:data
                    options:0
                    error:&error];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:endPoint]];
    [request setHTTPMethod:@"GET"];

    for (NSString* key in headers) {
        NSString* value = [[headers objectForKey:key] stringValue];
        [request setValue:value forHTTPHeaderField:key];
    }

     NSURLSession *session = [NSURLSession sharedSession];
     NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                             completionHandler:
                                   ^(NSData *data, NSURLResponse *response, NSError *error) {
                                        CDVPluginResult* pluginResult = nil;
                                       if (data == nil) {
                                            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
                                       } else {
                                           NSString *dataString =[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                           //NSLog(@"%@", dataString);
                                           pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:dataString];
                                       }
                                       [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                                   }];
     [task resume];
}

- (void)sendPost:(CDVInvokedUrlCommand*)command
{
    NSString* endPoint = [command.arguments objectAtIndex:0];
    NSString* jsonHeaders = [command.arguments objectAtIndex:1];
    NSString* body = [command.arguments objectAtIndex:2];

    endPoint = [NSString stringWithFormat:@"%@%@", baseAddress, endPoint];

    NSData *data = [jsonHeaders dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id headers = [NSJSONSerialization
                    JSONObjectWithData:data
                    options:0
                    error:&error];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:endPoint]];
    [request setHTTPMethod:@"POST"];

    for (NSString* key in headers) {
        NSString* value = [[headers objectForKey:key] stringValue];
        [request setValue:value forHTTPHeaderField:key];
    }

    NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];

     NSURLSession *session = [NSURLSession sharedSession];
     NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                             completionHandler:
                                   ^(NSData *data, NSURLResponse *response, NSError *error) {
                                        CDVPluginResult* pluginResult = nil;
                                       if (data == nil) {
                                            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
                                       } else {
                                           NSString *dataString =[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                           //NSLog(@"%@", dataString);
                                           pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:dataString];
                                       }
                                       [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                                   }];
     [task resume];    
}

@end
