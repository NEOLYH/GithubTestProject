//
//  LUSeverDelegate.m
//  Lu_MVP
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LUSeverDelegate.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation LUSeverDelegate
#pragma mark -
#pragma mark Method Resolution

- (NSArray<NSString *> *)appDelegateMethods
{
    static NSMutableArray *methods = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unsigned int methodCount = 0;
        // 获取UIApplicationDelegate协议所有协议方法
        struct objc_method_description *methodList = protocol_copyMethodDescriptionList(@protocol(UIApplicationDelegate), NO, YES, &methodCount);
        methods = [NSMutableArray arrayWithCapacity:methodCount];
        for (int i = 0; i < methodCount; i ++)
        {
            struct objc_method_description md = methodList[i];
            [methods addObject:NSStringFromSelector(md.name)];
        }
        free(methodList);
    });
    // 返回协议方法数组
    return methods;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL canResponse = [self methodForSelector:aSelector] != nil
    && [self methodForSelector:aSelector] != _objc_msgForward;
    if (! canResponse && [[self appDelegateMethods] containsObject:NSStringFromSelector(aSelector)])
    {
        canResponse = [[LUSeviceManager sharedManager] proxyCanResponseToSelector:aSelector];
    }
    return canResponse;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    // 分发消息
    [[LUSeviceManager sharedManager] proxyForwardInvocation:anInvocation];
}
@end
