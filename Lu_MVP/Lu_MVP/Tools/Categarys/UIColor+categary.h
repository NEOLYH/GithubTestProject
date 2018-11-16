//
//  UIColor+categary.h
//  Lu_MVP
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (categary)

// 将十六进制的颜色值转为UIColor
+ (UIColor *)getColor:(NSString *)hexColor;

// 主题颜色
+ (UIColor *)themeColor;

@end

NS_ASSUME_NONNULL_END
