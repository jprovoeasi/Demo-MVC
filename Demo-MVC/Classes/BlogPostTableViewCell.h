//
//  BlogPostTableViewCell.h
//  Demo-MVC
//
//  Created by Jonathan Provo on 07/08/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlogPost.h"

@interface BlogPostTableViewCell : UITableViewCell

- (void)configureForBlogPost:(BlogPost *)blogPost;

@end
