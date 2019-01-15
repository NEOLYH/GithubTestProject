//
//  AnimateView.m
//  LUMVP
//
//  Created by apple on 2019/1/9.
//  Copyright © 2019 apple. All rights reserved.
//

#define kLineW  [UIScreen mainScreen].bounds.size.width -10*2
#define kMargin 100
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "AnimateView.h"

@interface AnimateView ()
 
@end

@implementation AnimateView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addSubview:self.button];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    //由于UIBezierPath绘制出来的是矢量图形(即layer路径)并不能真正的展示出来,因此,想让它显示在图层上,需要设置线条颜色
    [[UIColor orangeColor] set];
    UIBezierPath * path = [[UIBezierPath alloc] init];
    path.lineWidth = 1.f; //线条宽度
    path.lineCapStyle = kCGLineCapRound; //端点类型 （圆形端点）
    path.lineJoinStyle = kCGLineCapRound; //连接类型
    path.miterLimit = 10.f; //最大斜接长度
    path.flatness = 10.f; //绘线精细程度
    path.usesEvenOddFillRule = YES; //判断奇偶数组的规则绘制图像,图形复杂时填充颜色的一种规则。类似棋盘
    [path moveToPoint:CGPointMake(kMargin, kMargin)]; //路径初始起点
    [path addLineToPoint:CGPointMake(kLineW, kMargin)]; //添加子路径
    [path stroke]; //根据坐标连线
    
    UIBezierPath * path2 = [[UIBezierPath alloc] init];
    [path2 moveToPoint:CGPointMake(kMargin, kMargin * 2)];
    [path2 addLineToPoint:CGPointMake(kLineW, kMargin * 2)];
    [path2 addLineToPoint:CGPointMake(kLineW, kMargin * 3)];
    [path2 closePath];
    [path2 stroke];
    
    //绘制矩形同样可以按点的形式创建
    UIBezierPath * path3 = [UIBezierPath bezierPathWithRect:CGRectMake(kMargin,  kMargin * 3, kLineW-kMargin, kMargin )];
    [path3 stroke];
    
   //绘制带圆角的矩形图案
    UIBezierPath *path4 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, kMargin, kMargin, kMargin) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
    [path4 fillWithBlendMode:kCGBlendModeMultiply alpha:0.3];
    [path4 stroke];
    
    //绘制圆形
    UIBezierPath * path5 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kMargin + 20, kMargin, 80, 80)];
    [path5 stroke];
    
    UIBezierPath * path6 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kMargin * 2 , kMargin, 100, 50)];
    [path6 stroke];
    
    // 7. 绘制一段圆弧
    UIBezierPath *path7 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kMargin - 20, kMargin*3) radius:50 startAngle:0.5*3.1415926 endAngle:3.1415926 clockwise:YES];
    [path7 stroke];
    
    // 9. 绘制竖直虚线
    UIBezierPath *verticalLinePath = [UIBezierPath bezierPath];
    CGFloat dash[] = {3.0, 3.0};
    [verticalLinePath setLineDash:dash count:2 phase:0.0];
    [verticalLinePath moveToPoint: CGPointMake(5, 0)];
    [verticalLinePath addLineToPoint: CGPointMake(5, ScreenHeight*2)];
    [verticalLinePath stroke];
    [verticalLinePath fill];
    
    // 10.绘制二次贝塞尔曲线
    UIBezierPath *path9 = [UIBezierPath bezierPath];
    [path9 moveToPoint:CGPointMake(kMargin, kMargin*5)];
    [path9 addQuadCurveToPoint:CGPointMake(kMargin + 100, 450) controlPoint:CGPointMake(200, 550)];
    [path9 stroke];
    
    // 11.绘制三次贝塞尔曲线
    UIBezierPath *path10 = [UIBezierPath bezierPath];
    [path10 moveToPoint:CGPointMake(50, 550)];
    [path10 addCurveToPoint:CGPointMake(300, 560) controlPoint1:CGPointMake(150, 480) controlPoint2:CGPointMake(250, 600)];
    [path10 addQuadCurveToPoint:CGPointMake(350, 500) controlPoint:CGPointMake(450, 500)];
    [path10 stroke];
    
    CALayer * anyLayer = [[CALayer alloc] init];
    anyLayer.backgroundColor = [UIColor redColor].CGColor;
    anyLayer.position = CGPointMake(10, 520);
    anyLayer.bounds = CGRectMake(0, 0, 8, 8);
    anyLayer.cornerRadius = 4;
    [self.layer addSublayer:anyLayer];
    
    CAKeyframeAnimation * keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframe.repeatCount = NSIntegerMax;
    keyframe.path = path10.CGPath;
    keyframe.duration = 15;
    keyframe.beginTime = CACurrentMediaTime() + 1;
    [anyLayer addAnimation:keyframe forKey:@"keyFrameAnimation"];
    
 }

-(UIButton *)button{
    if (_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(10, ScreenHeight - 100, 100, 80)];
        _button.backgroundColor = [UIColor redColor];
    }
    return _button;
}

@end
