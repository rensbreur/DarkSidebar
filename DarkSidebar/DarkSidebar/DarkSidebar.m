//
//  DarkSidebar.m
//  DarkSidebar
//
//  Created by Rens Breur on 06/02/2019.
//  Copyright © 2019 Rens Breur. All rights reserved.
//

#import "DarkSidebar.h"
#import <AppKit/AppKit.h>
#import <objc/runtime.h>

@implementation DarkSidebar

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method = class_getInstanceMethod([NSSplitViewController class], @selector(insertSplitViewItem:atIndex:));
        Method hook = class_getInstanceMethod([self class], @selector(_insertSplitViewItem:atIndex:));
        
        class_addMethod([NSSplitViewController class], @selector(_insertSplitViewItem:atIndex:), method_getImplementation(method), method_getTypeEncoding(method));
        class_replaceMethod([NSSplitViewController class], @selector(insertSplitViewItem:atIndex:), method_getImplementation(hook), method_getTypeEncoding(hook));
        
    });
}

- (void)_insertSplitViewItem:(NSSplitViewItem *)splitViewItem atIndex:(NSInteger)index {
    [self _insertSplitViewItem:splitViewItem atIndex:index];
    
    if ([NSStringFromClass([[splitViewItem viewController] class]) isEqualToString:@"TSidebarViewController"]) {
        [[[[splitViewItem viewController] view] superview] setAppearance: [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua]];
    }
    
}

@end
