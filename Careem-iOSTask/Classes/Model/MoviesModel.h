//
//  MoviesModel.h
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviesModel : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *ReleaseDate;
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *OverView;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;
+ (NSArray<MoviesModel *> *)modelsFromArray:(NSArray<NSDictionary *> *)array;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
