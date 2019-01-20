//
//  CommunityEngine.m
//  LUMVP
//
//  Created by apple on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommunityEngine.h"
#import "CommunityModel.h"
#import "WMGResultSet.h"


@implementation CommunityEngine

- (void)reloadDataWithParams:(NSDictionary *)params completion:( WMGEngineLoadCompletion )completion{
    if (_loadState == WMGEngineLoadStateLoading) {
        return;
    }
    
    _loadState = WMGEngineLoadStateLoading;
    NSDictionary * jsonData = [self readLocalFileWithName:@"header_list"];
    NSArray * arr = [jsonData objectForKey:@"data"];
    NSMutableArray * array = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CommunityModel * model = [[CommunityModel alloc] initWithDictionary:obj];
        [array addObject:model];
    }];
    [self.resultSet reset];
    [self.resultSet addItems:array];
    _loadState = WMGEngineLoadStateLoaded;
    if (completion) {
        completion(self.resultSet, nil);
    }
    
}

-(NSDictionary *)readLocalFileWithName:(NSString *)name{
    
    NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    id jsonObjc = [NSJSONSerialization JSONObjectWithData:data ?:[NSData data] options:0 error:nil];
    return jsonObjc;
}
@end
