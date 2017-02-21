//
//  NSImage+Extension.h
//  PersonProfileDoc
//
//  Created by zhaojw on 12/16/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage(Extension)
- (NSImage*)fx_fromBase64Data:(NSString*)base64StrData;
- (NSString*)fx_toBase64String;
@end
