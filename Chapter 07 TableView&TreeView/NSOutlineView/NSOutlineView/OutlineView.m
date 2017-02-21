//
//  OutlineView.m
//  NSOutlineView
//
//  Created by iDevFans on 2016/11/15.
//  Copyright © 2016年 zhaojw. All rights reserved.
//

#import "OutlineView.h"

@implementation OutlineView

- (id)makeViewWithIdentifier:(NSString *)identifier owner:(id)owner {
    id view = [super makeViewWithIdentifier:identifier owner:owner];
    if ([identifier isEqualToString:NSOutlineViewDisclosureButtonKey]) {
        // Do your customization
        // return disclosure button view
        [view setImage:[NSImage imageNamed:@"Plus"]];
        [view setAlternateImage:[NSImage imageNamed:@"Minus"]];
        [view setBordered:NO];
        [view setTitle:@""];
        return view;
    }
    return view;
}

-(NSMenu *)menuForEvent:(NSEvent *)event {
    NSPoint pt = [self convertPoint:[event locationInWindow] fromView:nil];
    NSInteger row = [self rowAtPoint:pt];
    if (row >= 0) {
        return self.treeMenu;
    }
    return [super menuForEvent:event];
}

@end
