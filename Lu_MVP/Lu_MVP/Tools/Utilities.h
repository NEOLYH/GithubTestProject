//
//  Utilities.h
//  Lu_MVP
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject

//是否为有效数组
+(BOOL)isValidArray:(id)object;
//是否为有效字典
+(BOOL)isValidDictionary:(id)object;

@end

NS_ASSUME_NONNULL_END
