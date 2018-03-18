//
//  CustomInfiniteIndicator.h
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//


#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomInfiniteIndicator : UIView

/**
 *  Ring thickness (default on iOS: 2, default on tvOS: 6)
 */
@property (nonatomic) IBInspectable CGFloat thickness;

/**
 *  Outer ring color (20% transparent gray)
 */
@property (nonatomic) IBInspectable UIColor *outerColor;

/**
 *  Inner ring color (Default: tint color)
 */
@property (nonatomic) IBInspectable UIColor *innerColor;

/**
 *  Whether is currently animating
 */
@property (nonatomic, readonly) BOOL animating;

- (void)startAnimating;
- (void)stopAnimating;

@end
