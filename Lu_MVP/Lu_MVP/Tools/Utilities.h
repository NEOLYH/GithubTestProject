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

/**
 是否为有效数组

 @param object 待检测的数组
 @return 返回值 YES NO
 */
+(BOOL)isValidArray:(id)object;


/**
 验证是否为有效的字典

 @param object 待检测的字典
 @return  YES NO
 */
+(BOOL)isValidDictionary:(id)object;


/**
 加载本地数据

 @param name 文件名称
 @return 返回字典类型json数据
 */
+(NSDictionary *)readLocalFileWithName:(NSString *)name;

/**
 加载本地json文件
 @param name json文件名称
 @return 返回数组类型json数据
 */
+(NSArray *)readlocaljsonName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
