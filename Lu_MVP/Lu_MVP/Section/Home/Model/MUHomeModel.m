//
//  MUHomeModel.m
//  LUMVP
//
//  Created by Faith on 2019/3/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MUHomeModel.h"
@interface MUHomeModel () 

@end

@implementation MUHomeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"music_id":@"id",
             @"album_id": @"album.id",
             @"album_name":@"album.name",
             @"album_cover":@"album.cover",
             @"coverBig":@"album.coverBig",
             @"coverSmall":@"album.coverSmall",
             @"artists_id":@"artists.id",
             @"artists_name":@"artists.name",
             };
}
@end
