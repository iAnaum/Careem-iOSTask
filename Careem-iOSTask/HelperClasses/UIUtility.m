//
//  UIUtility.m
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//


#import "UIUtility.h"
#import "ThemeEngine.h"

@implementation UIUtility

+(UIUtility *)sharedInstance {
    static UIUtility *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[UIUtility alloc] init];
    }
    return sharedInstance;
}

-(void)applyShadow:(UIView*)view shadowColorOpacity:(CGFloat)shadowColorOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius {
    
    view.layer.shadowColor = [ThemeEngine.sharedInstance colorFromHexString:@"000000" opacity:shadowColorOpacity].CGColor;
    view.layer.shadowOffset = shadowOffset;
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowRadius = shadowRadius;
    view.layer.masksToBounds = NO;
}

-(void)shakeView:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.07;
    animation.repeatCount = 4;
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(view.center.x - 10,  view.center.y)];
    animation.toValue = [NSValue valueWithCGPoint: CGPointMake(view.center.x + 10,  view.center.y)];
    [view.layer addAnimation:animation forKey:@"position"];
}

@end
