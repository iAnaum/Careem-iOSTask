//
//  ViewController.h
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/16/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchedMovies_TableViewCell.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *Movies;
}
@property (strong, nonatomic) IBOutlet UITableView *Search_TableView;
-(IBAction)Search:(id)sender;
@end

