//
//  BlogPostTableViewController.m
//  Demo-MVC
//
//  Created by Jonathan Provo on 07/08/15.
//  Copyright (c) 2015 EASI. All rights reserved.
//

#import "BlogPostTableViewController.h"

#import "BlogPostTableViewCell.h"

@interface BlogPostTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *blogPosts;

- (IBAction)didTapShuffleButton:(UIBarButtonItem *)sender;
- (void)createBlogPosts;
- (NSArray *)shuffleArray:(NSArray *)array;

@end

@implementation BlogPostTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // a UIViewController's dataSource and delegate are always set to self by default
    // this is done for demo purposes
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // create objects
    // in a real application this would come from a database or a web service
    [self createBlogPosts];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.blogPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the view
    BlogPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogPostCell" forIndexPath:indexPath];
    
    // get the model
    BlogPost *blogPost = self.blogPosts[indexPath.row];
    
    // configure the view
    [cell configureForBlogPost:blogPost];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // get the model
    BlogPost *blogPost = self.blogPosts[indexPath.row];
    
    // action based on the model
    blogPost.selected = !blogPost.selected;
    [tableView reloadData];
    
    NSString *title = @"Lorum ipsum";
    NSString *message = [NSString stringWithFormat:@"You selected: %@", blogPost.title];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - IBAction

- (IBAction)didTapShuffleButton:(UIBarButtonItem *)sender
{
    self.blogPosts = [self shuffleArray:self.blogPosts];
    [self.tableView reloadData];
}

- (IBAction)didTapSortButton:(UIBarButtonItem *)sender
{
    // method 1
    self.blogPosts = [self.blogPosts sortedArrayUsingComparator:^NSComparisonResult(BlogPost *obj1, BlogPost *obj2) {
        return [obj1.title compare:obj2.title];
    }];
    
    // method 2
//    self.blogPosts = [self.blogPosts sortedArrayUsingDescriptors:@[ [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES] ]];
    
    [self.tableView reloadData];
}

#pragma mark - Private

- (void)createBlogPosts
{
    NSString *lorumIpsum = @"Donec ullamcorper nulla non metus auctor fringilla. Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Nullam quis risus eget urna mollis ornare vel eu leo. Maecenas faucibus mollis interdum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam id dolor id nibh ultricies vehicula ut id elit.";
    NSArray *words = [[[lorumIpsum stringByReplacingOccurrencesOfString:@"." withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@""] componentsSeparatedByString:@" "];
    words = [self shuffleArray:words];
    
    NSMutableArray *posts = [NSMutableArray arrayWithCapacity:words.count];
    for (NSString *word in words) {
        BlogPost *post = [BlogPost createBlogPostWithTitle:word];
        [posts addObject:post];
    }
    self.blogPosts = posts;
}

- (NSArray *)shuffleArray:(NSArray *)array
{
    NSMutableArray *shuffledArray = [NSMutableArray arrayWithArray:array];
    
    NSUInteger count = array.count;
    for (NSUInteger i = 0; i < count - 1; i++) {
        NSInteger remainingCount = count - i;
        NSInteger randomIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:randomIndex];
    }
    
    return shuffledArray;
}

@end
