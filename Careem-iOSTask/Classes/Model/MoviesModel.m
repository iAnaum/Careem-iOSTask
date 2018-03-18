//
//  MoviesModel.m
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//

#import "MoviesModel.h"
static NSString * const MovieModelTitle  = @"title";
static NSString * const MovieModelReleaseDate = @"release_date";
static NSString * const MovieModelPosterURL    = @"poster_path";
static NSString * const MovieModelOverview    = @"overview";

@implementation MoviesModel


+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

+ (NSArray<MoviesModel *> *)modelsFromArray:(NSArray<NSDictionary *> *)array {
    NSMutableArray *models = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dict in array) {
        MoviesModel *model = [self modelWithDictionary:dict];
        if(model) {
            [models addObject:model];
        }
    }
    
    return [models copy];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = dictionary[MovieModelTitle];
    self.ReleaseDate = dictionary[MovieModelReleaseDate];
    self.OverView = dictionary[MovieModelOverview];
    self.url = dictionary[MovieModelPosterURL];
    return self;
}

@end
