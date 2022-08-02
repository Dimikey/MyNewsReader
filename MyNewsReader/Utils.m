//
//  Utils.m
//  MyNewsReader
//
//  Created by Dimikey on 01/08/2022.
//  Copyright © 2022 Dimikey. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void)showAlert:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [alert show];
}

@end
