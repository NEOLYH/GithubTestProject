//
//  CommunityModel.m
//  LUMVP
//
//  Created by apple on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommunityModel.h"

@implementation CommunityModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ids =  [dict objectForKey:@"ids"];
        self.title = [dict objectForKey:@"title"];
        self.artist = [dict objectForKey:@"artist"];
        self.pic = [dict objectForKey:@"pic"];
        self.music_url = [dict objectForKey:@"music_url"];
        self.file_name = [dict objectForKey:@"file_name"];
        self.content = [dict objectForKey:@"content"];
    }
    
    return self;
}

@end
