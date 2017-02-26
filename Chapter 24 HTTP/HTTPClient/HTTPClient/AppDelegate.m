//
//  AppDelegate.m
//  HTTPClient
//
//  Created by zhaojw on 2/21/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPClient.h"

#define kServerBaseUrl @"http://www.baidu.com"

@interface AppDelegate ()

@property(weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application

  HTTPClient *httpClient = [[HTTPClient alloc] init];

  NSString *urlString =
      [NSString stringWithFormat:@"%@%@", kServerBaseUrl, @"/VersionCheck"];

  [httpClient GET:urlString
       parameters:nil
          success:^(id responseObject) {

            NSString *responseStr =
                [[NSString alloc] initWithData:responseObject
                                      encoding:NSUTF8StringEncoding];
            NSLog(@"data =%@ ", responseStr);

          }
          failure:^(NSError *error){

          }];

  NSString *post = [[NSString alloc]
      initWithFormat:@"versionNo=%@&platform=%@&channel=%@&appName=%@", @"1.0",
                     @"Mac", @"appstore", @"DBAppX"];

  [httpClient POST:urlString
        parameters:post
           success:^(id responseObject) {

             NSString *responseStr =
                 [[NSString alloc] initWithData:responseObject
                                       encoding:NSUTF8StringEncoding];
             NSLog(@"data =%@ ", responseStr);

           }
           failure:^(NSError *error){

           }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

@end
