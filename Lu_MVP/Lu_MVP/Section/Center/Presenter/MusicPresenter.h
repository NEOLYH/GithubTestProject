//
//  MusicPresenter.h
//  LUMVP
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPNetworkHelper.h"

@protocol MusicProtocol <NSObject>

@optional
- (void)onGetMusicListSuccess:(id)model;
- (void)onGetMusicListFail:(NSInteger) errorCode des:(NSString *)des;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MusicPresenter : NSObject
@property(nonatomic,weak)id<MusicProtocol>delegate;
- (void)getMusicListWithUrlString:(NSString *)urlString param:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
