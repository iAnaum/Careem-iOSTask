//
//  UIUtility.h
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIUtility : NSObject

+(UIUtility *)sharedInstance;

-(void)applyShadow:(UIView*)view shadowColorOpacity:(CGFloat)shadowColorOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius;

-(void)shakeView:(UIView *)view;

@end
