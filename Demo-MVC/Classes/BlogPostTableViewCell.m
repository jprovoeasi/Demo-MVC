//
//  BlogPostTableViewCell.m
//  Demo-MVC
//
//  Created by Jonathan Provo on 07/08/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "BlogPostTableViewCell.h"

@interface BlogPostTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BlogPostTableViewCell

#pragma mark - Public

- (void)configureForBlogPost:(BlogPost *)blogPost
{
    self.titleLabel.text = blogPost.title;
    self.backgroundColor = (blogPost.selected ? [UIColor orangeColor] : [UIColor clearColor]);
}

@end
