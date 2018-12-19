//
//  PlaceHolderBaseView.h
//  LUMVP
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define widthPix kScreenWidth/320
#define heightPix kScreenHeight/568

//sun
#define kMaxWhiteCloudCount  11
#define kRotationAnimationTimes  80
#define kOffsetXAnimationTimes  100
#define kOffsetXScreenCount  3

NS_ASSUME_NONNULL_BEGIN

@interface PlaceHolderBaseView : UIView
@property(nonatomic,strong)NSMutableArray <UIView *> * cloudArray;

-(void)startAnimation;
-(void)stopAnimation;

//cloud
-(void)addCloud:(BOOL)isRain rainCount:(NSInteger)rainCount onView:(UIView *)view;
//cloud animation
- (CAAnimationGroup *)cloudAnimationWithFromValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue duration:(NSInteger)duration;
//horizontal animation
- (CABasicAnimation *)birdFlyAnimationWithToValue:(NSNumber *)toValue duration:(NSInteger)duration autoreverses:(BOOL)autoreverses;
//rotating animation
- (CABasicAnimation *)sunshineAnimationWithDuration:(NSInteger)duration;
//rain animation
- (CABasicAnimation *)rainAnimationWithDuration:(NSInteger)duration;
//alpha animation
- (CABasicAnimation *)rainAlphaWithDuration:(NSInteger)duration;

@end

NS_ASSUME_NONNULL_END
