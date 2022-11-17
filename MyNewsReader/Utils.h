//
//  Utils.h
//  MyNewsReader
//
//  Created by Dimikey on 01/08/2022.
//  Copyright © 2022 Dimikey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject
    + (void)showAlert:(NSString*) message;
    + (NSData*)loadFileByURL:(NSString*) url;
@end

NS_ASSUME_NONNULL_END
