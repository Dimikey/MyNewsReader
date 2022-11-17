//
//  Utils.m
//  MyNewsReader
//
//  Created by Dimikey on 01/08/2022.
//  Copyright © 2022 Dimikey. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void)showAlert:(NSString*) message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [alert show];
}


+ (NSData*)loadFileByURL:(NSString*) urlToImage {
    // TODO: LOADING ASYNCHRONOUS IS A MUST!!! loading animation is also important
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:urlToImage]];
    
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

@end
