//
//  Utilities.m
//  Lu_MVP
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities
//是否为有效数组
+ (BOOL)isValidArray:(id)object
{
    return object && [object isKindOfClass:[NSArray class]] && ((NSArray *)object).count;
}
@end
