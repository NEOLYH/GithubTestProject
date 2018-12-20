//
//  MusicEntity.h
//  LUMVP
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicEntity : NSObject
@property (nonatomic, copy) NSNumber *musicId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *musicUrl;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString * artist;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *file_name;
@property (nonatomic, assign) BOOL isFavorited;
@end

NS_ASSUME_NONNULL_END
