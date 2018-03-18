//
//  ViewController.m
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/18/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//

#import "ViewController.h"
#import "CustomInfiniteIndicator.h"
#import "MoviesModel.h"
#import "ThemeEngine.h"
#import "UIUtility.h"
#import "UIScrollView+InfiniteScroll.h"
#import "UIApplication+NetworkIndicator.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Search_TableView,Search_TextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.Search_TableView registerNib:[UINib nibWithNibName:@"SearchedMovies_TableViewCell" bundle:nil] forCellReuseIdentifier:@"movie"];
    [self.Search_TableView setHidden:YES];
    
    NSString *plistPath = [self InternalData];
    NSMutableArray *dict = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@",dict);
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:dict];
    arrayWithoutDuplicates = [orderedSet array];
    NSLog(@"%@",arrayWithoutDuplicates);
    [self setupDropdown];
 }


-(NSString*)InternalData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"SuggestionsData.plist"];
    return plistPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self setupDropdown];
}



-(void)setupDropdown {
     NSString *colorCode = @"4AA328";
    _tableViewContainer = [[UIView alloc]init];
    _tableViewContainer.backgroundColor = [UIColor whiteColor];
    _tableViewContainer.layer.cornerRadius = 4;
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setSeparatorColor: [ThemeEngine.sharedInstance colorFromHexString:colorCode]];
}


-(IBAction)Search:(id)sender{
    if ([self.Search_TextField.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Kindly Enter Something into Search" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
         [self MainTableViewLoading];
    }
   
}


-(void)MainTableViewLoading{
    [_tableViewContainer removeFromSuperview];
    TableViewDetection = @"Main";
    [self.Search_TextField resignFirstResponder];
    Movies = [NSArray array];
    counter = 1;
    total_pages = 0;
    
    __weak typeof(self) weakSelf = self;
    
    // Create custom indicator
    CGRect indicatorRect = CGRectMake(0, 0, 24, 24);
    CustomInfiniteIndicator *indicator = [[CustomInfiniteIndicator alloc] initWithFrame:indicatorRect];
    
    // Set custom indicator
    self.Search_TableView.infiniteScrollIndicatorView = indicator;
    
    // Set custom indicator margin
    self.Search_TableView.infiniteScrollIndicatorMargin = 40;
    
    // Set custom trigger offset
    self.Search_TableView.infiniteScrollTriggerOffset = 500;
    
    // Add infinite scroll handler
    [self.Search_TableView addInfiniteScrollWithHandler:^(UITableView *tableView) {
        [weakSelf fetchData:^{
            // Finish infinite scroll animations
            [tableView finishInfiniteScroll];
        }];
    }];
    
    
    // Load initial data
    [self.Search_TableView reloadData];
    [self.Search_TableView beginInfiniteScroll:YES];
}



#pragma mark - UITableView DataSource and Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger A = 0;
    if ([TableViewDetection isEqualToString:@"Main"]) {
       A =  [Movies count];
    }
    if ([TableViewDetection isEqualToString:@"Mini"]) {
        A =  [arrayWithoutDuplicates count];
    }
    return A;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([TableViewDetection isEqualToString:@"Main"]) {
        static NSString *simpleTableIdentifier = @"movie";
        SearchedMovies_TableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (!cell) {
            cell = [[SearchedMovies_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        MoviesModel *movie = Movies[indexPath.row];
        cell.label_MovieName.text = movie.title;
        cell.label_MovieReleaseDate.text = [NSString stringWithFormat:@"Release Date:%@",movie.ReleaseDate];
        cell.label_MovieOverView.text = movie.OverView;
        
        NSString *test2 = [NSString stringWithFormat:@"%s%@",PosterPath,movie.url];
        [cell.Poster_Image sd_setImageWithURL:[NSURL URLWithString:test2]
                             placeholderImage:[UIImage imageNamed:@"1024.png"]];
        
        return cell;
    }
    
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.preservesSuperviewLayoutMargins = NO;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.text = arrayWithoutDuplicates[indexPath.row];
        [cell.textLabel setBackgroundColor:[UIColor redColor]];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([TableViewDetection isEqualToString:@"Mini"]) {
        NSString *test =  arrayWithoutDuplicates[indexPath.row];
        self.Search_TextField.text = test;
        [self MainTableViewLoading];
    }
    else{
        NSLog(@"do nothing");
    }
    
}


#pragma mark - Private methods
- (void)showRetryAlertWithError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action) {
        
    }]];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)fetchData:(void(^)(void))completion {
    NSString *Url = [NSString stringWithFormat:@"%s%@&page=%ld",JSONAPI,self.Search_TextField.text,(long)counter];
    NSLog(@"%@",Url);
    NSURL *requestURL = [NSURL URLWithString:Url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData *data, __unused NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleResponse:data error:error];
            
            [[UIApplication sharedApplication] stopNetworkActivity];
            
            if(completion) {
                completion();
            }
        });
    }];
    
    [[UIApplication sharedApplication] startNetworkActivity];
    NSTimeInterval delay = (Movies.count == 0 ? 0 : 5);
    [task performSelector:@selector(resume) withObject:nil afterDelay:delay];
}


- (void)handleResponse:(NSData *)data error:(NSError *)error {
    if(error) {
        [self showRetryAlertWithError:error];
        return;
    }
    
    NSError *JSONError;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
    
    if(JSONError) {
        [self showRetryAlertWithError:JSONError];
        return;
    }
    
    // parse data into models
    NSArray *results = responseDict[@"results"];
    
    if ([results count] == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"No Search Results found" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else{
        NSString *plistPath = [self InternalData];
        NSMutableArray *plistDic = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        if (plistDic.count > 0) {
            [plistDic addObject:self.Search_TextField.text];
        }
        else{
            plistDic =  [[NSMutableArray alloc] initWithCapacity:10];
            [plistDic addObject:self.Search_TextField.text];
        }
        
        
        NSLog(@"%@",plistDic);
        [plistDic writeToFile:plistPath atomically:YES];

        NSArray *newModels = [MoviesModel modelsFromArray:results];
        
        // create new index paths
        NSIndexSet *newIndexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(Movies.count, newModels.count)];
        NSMutableArray *newIndexPaths = [[NSMutableArray alloc] init];
        
        [newIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, __unused BOOL *stop) {
            [newIndexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
        }];
        
        // update data source
        total_pages = [responseDict[@"total_pages"] integerValue];
        counter += 1;
        Movies = [Movies arrayByAddingObjectsFromArray:newModels];
        
        // update table view
        [self.Search_TableView setHidden:NO];
        [self.Search_TableView beginUpdates];
        [self.Search_TableView insertRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.Search_TableView endUpdates];
    }
    
}


-(void)Open{
    NSString *plistPath = [self InternalData];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"manuallyData" ofType:@"plist"];
    }
    NSMutableArray *dict = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@",dict);
    if ([dict count] > 0) {
        [self.Search_TableView setHidden:YES];
        [self.Search_TableView endUpdates];
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:dict];
        arrayWithoutDuplicates = [orderedSet array];
        NSLog(@"%@",arrayWithoutDuplicates);
            _tableViewContainer.frame = CGRectMake(self.Search_TextField.frame.origin.x, 100, self.Search_TextField.frame.size.width, 200);
            _tableView.frame = CGRectMake(0, 0, _tableViewContainer.frame.size.width, _tableViewContainer.frame.size.height);
            TableViewDetection = @"Mini";
            [self.view addSubview:_tableViewContainer];
            [_tableViewContainer addSubview:_tableView];
            [_tableView reloadData];
            [UIUtility.sharedInstance applyShadow:_tableViewContainer shadowColorOpacity:0.25 shadowOffset:CGSizeMake(2.0, 2.0) shadowRadius:12.0];
        
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self Open];
    return YES;
}

@end
