//
//  UIApplication+NetworkIndicator.m
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//


#import "UIApplication+NetworkIndicator.h"

@implementation UIApplication (NetworkIndicator)

#if TARGET_OS_TV

- (void)startNetworkActivity {}
- (void)stopNetworkActivity {}

#else

static NSInteger networkActivityCount = 0;

- (void)startNetworkActivity {
    networkActivityCount++;
    
    [self setNetworkActivityIndicatorVisible:YES];
}

- (void)stopNetworkActivity {
    if(networkActivityCount < 1) {
        return;
    }
    
    if(--networkActivityCount == 0) {
        [self setNetworkActivityIndicatorVisible:NO];
    }
}

#endif

@end
