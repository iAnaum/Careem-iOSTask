//
//  ThemeEngine.h
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemeEngine : NSObject

+(ThemeEngine *)sharedInstance;
-(UIColor *)colorFromHexString:(NSString *)hexString;
-(UIColor *)colorFromHexString:(NSString *)hexString opacity:(CGFloat)opacity;

@end
