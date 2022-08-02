//
//  Utils.h
//  MyNewsReader
//
//  Created by Dimikey on 01/08/2022.
//  Copyright © 2022 Dimikey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject
    + (void)showAlert:(NSString*) message;
    + (NSData*)loadFileFromURL:(NSString*) url;
@end

NS_ASSUME_NONNULL_END