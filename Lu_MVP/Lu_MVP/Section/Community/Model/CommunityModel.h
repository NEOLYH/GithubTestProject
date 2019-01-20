//
//  CommunityModel.h
//  LUMVP
//
//  Created by apple on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMGBusinessModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommunityModel : NSObject

@property(nonatomic, copy) NSString * ids;
@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * artist;
@property(nonatomic, copy) NSString * pic;
@property(nonatomic, copy) NSString * music_url;
@property(nonatomic, copy) NSString * file_name;
@property(nonatomic, copy) NSString * content;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
