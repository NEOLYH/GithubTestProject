//
//  LUSeviceManager.h
//  Lu_MVP
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ML_EXPORT_SERVICE(name) \
+ (void)load {[[LUSeviceManager sharedManager] registerService:[self new]];} \
- (NSString *)serviceName { return @#name; }

NS_ASSUME_NONNULL_BEGIN
@protocol LUService <UIApplicationDelegate>
@required
-(NSString *)serviceName;

@end

@interface LUSeviceManager : NSObject
+(instancetype)sharedManager;

//注册服务
-(void)registerService:(id<LUService>)service;

//获取服务
-(id<LUService>)getAppService:(NSString *)serviceName;

-(BOOL)proxyCanResponseToSelector:(SEL)aSelector;

-(void)proxyForwardInvocation:(NSInvocation *)anInvocation;

@end

NS_ASSUME_NONNULL_END
