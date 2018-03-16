//
//  ViewController.m
//  Careem-iOSTask
//
//  Created by Anaum Hamid on 3/16/18.
//  Copyright © 2018 Anaum Hamid. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Search_TableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.Search_TableView registerNib:[UINib nibWithNibName:@"SearchedMovies_TableViewCell" bundle:nil] forCellReuseIdentifier:@"movie"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager GET:@"http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"[success]: %@",responseObject);
        Movies  = [[NSMutableArray alloc]init];
        Movies  = [responseObject valueForKey:@"results"];
        NSLog(@"%@",Movies);
        [Search_TableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"[error]: %@", error);
            }];
    
    

 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Search:(id)sender{
    NSLog(@"do nothing");
}

#pragma mark - UITableView DataSource and Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Movies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"movie";
    SearchedMovies_TableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        // if cell is empty create the cell
        cell = [[SearchedMovies_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.label_MovieName.text = [[Movies valueForKey:@"title"]objectAtIndex:indexPath.row];
    NSString *test = [NSString stringWithFormat:@"Release Date: %@",[[Movies valueForKey:@"release_date"]objectAtIndex:indexPath.row]];
    cell.label_MovieReleaseDate.text = test;
    cell.label_MovieOverView.text = [[Movies valueForKey:@"overview"]objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"do nothing");
}



@end
