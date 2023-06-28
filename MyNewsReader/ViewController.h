//
//  ViewController.h
//  MyNewsReader
//
//  Created by Dimikey on 10/07/2022.
//  Copyright © 2022 Dimikey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleViewController.h"
#import "Utils.h"

@interface ViewController : UIViewController {
    NSMutableArray* tableData;
    NSDictionary* news;
    NSUInteger currentArticleId;
    NSString* keyword;
    NSString* apiKey;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UITextField *textFieldKeyword;

- (IBAction)buttonReloadTouchDown:(id)sender;
- (IBAction)textFieldKeywordTriggered:(id)sender;


@end

