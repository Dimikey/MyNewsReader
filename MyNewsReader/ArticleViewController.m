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
        
    // TODO: handle empty pictures. If an article doesn't have an image or no internet connection is present, then show some dummy image
    // Image
    //NSLog(@"Attempting to load article image... %@", _currentArticle[@"urlToImage"]);
    if(![_currentArticle[@"urlToImage"] isKindOfClass:[NSNull class]])
        image = [[UIImage alloc] initWithData:[self loadImage]];
    else
        image = [[UIImage alloc] init];
    
    _imageView.image = image;
}

// TODO: move to separate "utils" class
- (NSData*)loadImage {
    // TODO: LOADING ASYNCHRONOUS IS A MUST!!! loading animation is also important
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:_currentArticle[@"urlToImage"]]];
    
    NSError* error = nil;
    NSHTTPURLResponse* responseCode = nil;
    
    // do request
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];

    if([responseCode statusCode] != 200){
        [Utils showAlert:[NSString stringWithFormat:@"HTTP error, status code: %li", [responseCode statusCode]]];
        return nil;
    }

    return responseData;
}

- (IBAction)buttonCloseTouchDown:(id)sender {
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
