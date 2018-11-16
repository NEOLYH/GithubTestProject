//
//  LUSeviceManager.m
//  Lu_MVP
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LUSeviceManager.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface LUSeviceManager ()

@property(nonatomic, strong) Class<UIApplicationDelegate> appDelegateClass;

@property(nonatomic, strong) NSMutableDictionary<NSString*, id<LUService>> *servicesMap;

@end

// 由子类实现服务代理方法，父类负责把这些实现添加到 ApplicationDelegate 中
// 这些都需要在 ApplicationDelegate 实例创建之前执行
@implementation LUSeviceManager

+(instancetype)sharedManager{
    static LUSeviceManager  * sharedManager= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [LUSeviceManager new];
    });
    
    return sharedManager;
}

-(instancetype)init{
    if (self = [super init]) {
        self.servicesMap = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)registerService:(id<LUService>)service{
    if (!service) {
        return;
    }
    
    id<LUService> pre = self.servicesMap[[service serviceName]];
    
    if (pre) {
        if ([service isKindOfClass:[pre class]]) {
            self.servicesMap[[service serviceName]] = service;
        }else{
            NSAssert([pre isKindOfClass:[service class]],
                     @"Tried to register both %@ and %@ as the handler of %@ service. \
                     Cannot determine the right class to use because neither inherits from the other.",
                     [pre class], [service class], [service serviceName]);
        }
    }else{
        self.servicesMap[[service serviceName]] = service;
    }
}

-(id<LUService>)getAppService:(NSString *)serviceName{
    
    id<LUService> pre = self.servicesMap[serviceName];
    if (pre) {
        return pre;
    }else{
        return nil;
    }
}

-(BOOL)proxyCanResponseToSelector:(SEL)aSelector{
    __block IMP imp = NULL;
    [self.servicesMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<LUService>  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if([obj respondsToSelector:aSelector]){
            imp = [(id)obj methodForSelector:aSelector];
            NSMethodSignature * signature = [(id)obj methodSignatureForSelector:aSelector];
            if(signature.methodReturnLength > 0 && strcmp(signature.methodReturnType, @encode(BOOL)) != 0){
                imp = NULL;
            }
            *stop = YES;
        }
    }];
    return imp != NULL && imp != _objc_msgForward;
}

-(NSString *)objcTypeFromSignature:(NSMethodSignature *)signature{
    NSMutableString * types = [NSMutableString stringWithFormat:@"%s",signature.methodReturnType?:"v"];
    for(NSInteger i = 0; i< signature.numberOfArguments;i++){
        [types appendFormat:@"%s",[signature getArgumentTypeAtIndex:i]];
    }
    return [types copy];
}

-(void)proxyForwardInvocation:(NSInvocation *)anInvocation{
    NSMethodSignature *signature = anInvocation.methodSignature;
    NSUInteger argCount = signature.numberOfArguments;
    __block BOOL returnValue = NO;
    NSUInteger returnLength = signature.methodReturnLength;
    void * returnValueBytes = NULL;
    if (returnLength > 0) {
         // alloca栈上申请空间,用完马上就释放.
        returnValueBytes = alloca(returnLength);
    }
    
    [self.servicesMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<LUService>  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj respondsToSelector:anInvocation.selector]) {
            return;
        }
        
        // check the signature
        NSAssert([[self objcTypeFromSignature:signature] isEqualToString:[self objcTypeFromSignature:[(id)obj methodSignatureForSelector:anInvocation.selector]]],  @"Method signature for selector (%@) on (%@ - `%@`) is invalid. \
                 Please check the return value type and arguments type.",
                 NSStringFromSelector(anInvocation.selector), obj.serviceName, obj);
          // copy the invokation
        NSInvocation *invok = [NSInvocation invocationWithMethodSignature:signature];
        
        invok.selector = anInvocation.selector;
        // copy arguments
        for (NSUInteger i = 0; i<argCount; i++) {
            const char *argType = [signature getArgumentTypeAtIndex:i];
            NSUInteger argSize  = 0;
            NSGetSizeAndAlignment(argType, &argSize, NULL);
            void * argValue = alloca(argSize);
            [anInvocation getArgument:&argValue atIndex:i];
            [invok setArgument:&argValue atIndex:i];
        }
         // reset the target
        invok.target = obj;
        
        // invoke
        [invok invoke];
        
        // get the return value
        
        if(returnValueBytes){
            [invok getReturnValue:returnValueBytes];
            returnValue = returnValue || *((BOOL *)returnValueBytes);
        }
        
    }];
    
    // set return value
    if (returnValueBytes)
    {
        [anInvocation setReturnValue:returnValueBytes];
    }
    
}
@end
