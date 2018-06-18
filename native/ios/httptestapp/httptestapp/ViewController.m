//
//  ViewController.m
//  httptestapp
//
//  Created by spaf94 on 10/06/2018.
//  Copyright © 2018 spaf94. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSString *baseAddress = @"";
NSString *endPoint = @"";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)button:(id)sender {
    
    baseAddress = @"https://demo.tellspec.com:443/v1/";
    //[self sendGet:@"new-password/5developersplus1@gmail.com":@"{\"Content-Type\":\"application/json\",\"Accept\":\"application/json\"}"];
    [self sendPost:@"log-in?first-time=true":@"{\"Content-Type\":\"application/json\",\"Accept\":\"application/json\"}":@"{\"email\":\"5developersplus1@gmail.com\",\"password\": \"5developers+1\"}"];
    /*
     endPoint = [NSString stringWithFormat:@"%@-%s", baseAddress, "new-password/5developersplus1@gmail.com"];
    
    //GET
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://demo.tellspec.com:443/v1/new-password/5developersplus1@gmail.com"]];
    [request setHTTPMethod:@"GET"];
    
    NSString *jsonHeaders = @"{\"Content-Type\":\"application/json\",\"Accept\":\"application/json\"}";
    NSData *data = [jsonHeaders dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id headers = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (data == nil) {
                                          [self printCannotLoad];
                                      } else {
                                          [self parseWeatherJSON:data];
                                      }
                                  }];
    [task resume];
     */
     
     }

- (void) sendGet:(NSString*)endPoint:(NSString*)jsonHeaders{

    endPoint = [NSString stringWithFormat:@"%@%@", baseAddress, endPoint];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:endPoint]];
    [request setHTTPMethod:@"GET"];
     
     NSData *data = [jsonHeaders dataUsingEncoding:NSUTF8StringEncoding];
     NSError *error = nil;
     id headers = [NSJSONSerialization
                   JSONObjectWithData:data
                   options:0
                   error:&error];
    
    for (NSString* key in headers) {
        id value = headers[key];
        [request setValue:value forHTTPHeaderField:key];
    }
    
     NSURLSession *session = [NSURLSession sharedSession];
     NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                             completionHandler:
                                   ^(NSData *data, NSURLResponse *response, NSError *error) {
                                       if (data == nil) {

                                       } else {
                                           //NSString *dataString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
                                           //NSString *dataString = [NSString stringWithFormat:@"%@", data];
                                           NSString *dataString =[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                           NSLog(@"%@", dataString);
                                           
                                       }
                                   }];
     [task resume];
     
     }

- (void) sendPost:(NSString*)endPoint:(NSString*)jsonHeaders:(NSString*)body{
    endPoint = [NSString stringWithFormat:@"%@%@", baseAddress, endPoint];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:endPoint]];
    [request setHTTPMethod:@"POST"];
    
    NSData *data = [jsonHeaders dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id headers = [NSJSONSerialization
                  JSONObjectWithData:data
                  options:0
                  error:&error];
    
    for (NSString* key in headers) {
        id value = headers[key];
        [request setValue:value forHTTPHeaderField:key];
    }
    
    NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (data == nil) {
                                          
                                      } else {
                                          //NSString *dataString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
                                          //NSString *dataString = [NSString stringWithFormat:@"%@", data];
                                          NSString *dataString =[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                          NSLog(@"%@", dataString);
                                          
                                      }
                                  }];
    [task resume];
    
}
    - (void) parseWeatherJSON:(NSData *) jsonData {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:jsonData
                     options:0
                     error:&error];
        
        if(error) {
            [self printCannotLoad];
            return;
        }
    }
    
    - (void) printCannotLoad {
        dispatch_sync(dispatch_get_main_queue(), ^{
            //valueLabel.text = @"cannot load";
        });
    }@end
