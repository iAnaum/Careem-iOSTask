//
//  ViewController.h
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/16/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchedMovies_TableViewCell.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    NSArray *Movies;
    NSInteger counter;
    NSInteger total_results;
    NSInteger total_pages;
    NSString *TableViewDetection;
    NSArray *arrayWithoutDuplicates;
    
}
@property (weak, nonatomic) IBOutlet UITableView *Search_TableView;
@property (weak, nonatomic) IBOutlet UITextField *Search_TextField;
@property (strong, nonatomic) UIView *tableViewContainer;
@property (strong, nonatomic) UITableView *tableView;
-(IBAction)Search:(id)sender;
@end

