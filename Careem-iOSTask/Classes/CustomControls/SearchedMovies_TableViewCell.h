//
//  SearchedMovies_TableViewCell.h
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchedMovies_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Poster_Image;

@property (weak, nonatomic) IBOutlet UILabel *label_MovieName;
@property (weak, nonatomic) IBOutlet UILabel *label_MovieReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *label_MovieOverView;
@end
