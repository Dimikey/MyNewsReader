//
//  ArticleViewController.h
//  MyNewsReader
//
//  Created by Dimikey on 29/07/2022.
//  Copyright © 2022 Dimikey. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleViewController : UIViewController {
    UIImage* image;
}

@property (weak, nonatomic) IBOutlet UIButton *buttonClose;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) NSDictionary* currentArticle;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void) loadImage:(NSString*)link;

@end

NS_ASSUME_NONNULL_END
