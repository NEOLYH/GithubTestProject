//
//  CommunityViewModel.h
//  LUMVP
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommunityViewModel : NSObject
-(void)communityNetWorkWithUrl:(NSString *)url paramas:(NSDictionary *)paramas success:(void(^)(NSArray * dataArray))success;
@end

NS_ASSUME_NONNULL_END
