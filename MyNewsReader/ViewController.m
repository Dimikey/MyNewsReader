//
//  ViewController.m
//  MyNewsReader
//
//  Created by Dimikey on 10/07/2022.
//  Copyright © 2022 Dimikey. All rights reserved.
//

#define DEBUG_ENABLED YES

#define API_KEY @"eb56197837c44ab2a268e7dfe2dedbb7"
#define DEFAULT_KEYWORD @"Apple"
#define JSON_URL @"https://newsapi.org/v2/everything?q=%@&apiKey=%@"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    /* TODO: handle absent internet connection. Store JSON on device and use it if no connection is present.
     if its the first time user opens the app, just show empty cells and error message */
    
    // Prepare default properties
    apiKey = API_KEY;
    keyword = DEFAULT_KEYWORD;
    
    [self reloadNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"simpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

- (void)updateControls {
    NSNumber* newsCount = [[NSNumber alloc] initWithInteger:0];
    
    if(news) {
        newsCount = news[@"totalResults"];
    } else {
        NSLog(@"updateControls failed to get number of news");
        newsCount = [[NSNumber alloc] initWithInteger:-1];
    }
    
    _labelStatus.text = [NSString stringWithFormat: @"News: %@", newsCount];
    
    [_tableView reloadData];
}

- (void)reloadNews {
    // Empty the news list, in case it already contained something
    [tableData removeAllObjects];
    
    // Get our JSON
    NSData* jsonData = [[NSData alloc] initWithData:
                        [Utils loadFileByURL:
                         [NSString stringWithFormat: JSON_URL, keyword, API_KEY]]];
    news = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    if(!news) {
        [Utils showAlert:@"Error parsing JSON data."];
        return;
    } else {
        [Utils showAlert:news[@"status"]];
    }
    
    // Fill the tableView with article titles
    tableData = [[NSMutableArray alloc] init];
    NSArray* articles = news[@"articles"];
    
    for(int i = 0; i < articles.count; i++)
        [tableData addObject:articles[i][@"title"]];
    
    [self updateControls];
}


// User chooses a news entry
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    currentArticleId = indexPath.row;
    
    [self performSegueWithIdentifier:@"showArticleSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showArticleSegue"]) {
        ArticleViewController *controller = (ArticleViewController *)segue.destinationViewController;
        //controller.isDetailingEnabled = YES;
        
        controller.currentArticle = news[@"articles"][currentArticleId];
    }
}

- (IBAction)buttonReloadTouchDown:(id)sender {
    [self reloadNews];
}

- (IBAction)textFieldKeywordTriggered:(id)sender {
    
    // Validate text field
    if(_textFieldKeyword.text.length <= 0) {
        NSLog(@"Keyword is too short, using default");
        keyword = DEFAULT_KEYWORD;
    }
    else if (_textFieldKeyword.text.length > 30) {
        NSLog(@"Keyword is too long, using default");
        keyword = DEFAULT_KEYWORD;
    }
    else
        keyword = _textFieldKeyword.text;
    
    
    
    // Dismiss keyboard
    [self.view endEditing:YES];
    
    [self reloadNews];
}
@end
