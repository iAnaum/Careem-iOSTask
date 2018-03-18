//
//  ThemeEngine.m
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//


#import "ThemeEngine.h"

@implementation ThemeEngine

+(ThemeEngine *)sharedInstance {
    static ThemeEngine *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[ThemeEngine alloc] init];
    }
    return sharedInstance;
}

-(UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    //[scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

-(UIColor *)colorFromHexString:(NSString *)hexString opacity:(CGFloat)opacity {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    //[scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:opacity];
}

@end
