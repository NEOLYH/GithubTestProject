//
//  MUHomeModel.h
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUHomeModel : NSObject

@property(nonatomic, assign) NSInteger album_id;
@property(nonatomic, copy) NSString * album_name;
@property(nonatomic, copy) NSString * album_cover;
@property(nonatomic, copy) NSString * coverBig;
@property(nonatomic, copy) NSString * coverSmall;
@property(nonatomic, assign) NSInteger artists_id;
@property(nonatomic, copy) NSString * artists_name;
@property(nonatomic, copy) NSString * name;
@property(nonatomic, assign) NSInteger music_id;
@property(nonatomic, assign) BOOL needPay;
@end

NS_ASSUME_NONNULL_END
