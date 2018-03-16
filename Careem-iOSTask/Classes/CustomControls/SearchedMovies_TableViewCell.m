//
//  SearchedMovies_TableViewCell.m
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/16/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//

#import "SearchedMovies_TableViewCell.h"

@implementation SearchedMovies_TableViewCell
@synthesize label_MovieName,label_MovieOverView,label_MovieReleaseDate,Poster_Image;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
