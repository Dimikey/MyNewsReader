//
//  ArticleViewController.m
//  MyNewsReader
//
//  Created by Dimikey on 29/07/2022.
//  Copyright © 2022 Dimikey. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@end


@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Check for all fields not to be NSNull
    // otherwise we will encuounter a crash (unhandled exception)
    
    // Title
    if(![_currentArticle[@"title"] isKindOfClass:[NSNull class]]) {
        _navigationBar.items[0].title = _currentArticle[@"title"];
        _articleTitleLabel.text = _currentArticle[@"title"];
    }
    else {
        _navigationBar.items[0].title = @"No title";
        _articleTitleLabel.text = @"No title";
    }
    
    // Author
    if(![_currentArticle[@"author"] isKindOfClass:[NSNull class]])
        _authorLabel.text = _currentArticle[@"author"];
    else
        _authorLabel.text = @"No author";
    
    // Publication date
    if(![_currentArticle[@"publishedAt"] isKindOfClass:[NSNull class]])
        _pubDateLabel.text = _currentArticle[@"publishedAt"];
    else
        _pubDateLabel.text = @"No pub date";
    
    // Content
    if(![_currentArticle[@"content"] isKindOfClass:[NSNull class]])
        _contentLabel.text = _currentArticle[@"content"];
    else
        _contentLabel.text = @"No content";

    // Image
    // Loading image async
    //[NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:_currentArticle[@"urlToImage"]];
    [_activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"image download thread start");
        if(![_currentArticle[@"urlToImage"] isKindOfClass:[NSNull class]]) {
            
            NSData* imageData = [Utils loadFileByURL:_currentArticle[@"urlToImage"]];
            
            if(imageData != nil) {
                image = [[UIImage alloc] initWithData:imageData];
            }
            else {
                // Image failed to load from web, set dummy one
                NSLog(@"Image load failed");
                image = [UIImage imageNamed:@"DummyImage"];
            }
        }
        else {
            // No URL was supplied
            NSLog(@"Image url was not supplied");
            image = [UIImage imageNamed:@"DummyImage"];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"updateImageView thread start");
            [self updateImageView];
            [_activityIndicator stopAnimating];
            NSLog(@"updateImageView thread end");
        });
        
        NSLog(@"image download thread end");
    });
}

- (void) updateImageView {
        _imageView.image = image;
}


- (IBAction)buttonCloseTouchDown:(id)sender {
    // TODO: replace deprecated
    [self dismissModalViewControllerAnimated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
