//
//  MusicPresenter.m
//  LUMVP
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MusicPresenter.h"
#import "Utilities.h"
#import "MusicEntity.h"
#import "MJExtension.h"

@implementation MusicPresenter

- (void)getMusicListWithUrlString:(NSString *)urlString param:(NSDictionary *)param{
    
   NSDictionary * dict =  [Utilities readLocalFileWithName:@"music_list"];
    NSLog(@"array:%@",dict);
    if ([dict isKindOfClass:[NSDictionary class]]) {
        NSArray * model = [MusicEntity mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        if ([self.delegate respondsToSelector:@selector(onGetMusicListSuccess:)]) {
            [self.delegate onGetMusicListSuccess:model];
        }
    }else{
        
    }
}

@end
