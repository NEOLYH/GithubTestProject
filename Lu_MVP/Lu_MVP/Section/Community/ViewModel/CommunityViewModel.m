//
//  CommunityViewModel.m
//  LUMVP
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommunityViewModel.h"
#import "PPNetworkHelper.h"
#import "Community.h"

@implementation CommunityViewModel

-(void)communityNetWorkWithUrl:(NSString *)url paramas:(NSDictionary *)paramas success:(void(^)(NSArray * dataArray))success{
    if (url) {
        return;
    }
    [PPNetworkHelper setValue:@"" forHTTPHeaderField:@""];
    [PPNetworkHelper GET:url parameters:paramas responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
