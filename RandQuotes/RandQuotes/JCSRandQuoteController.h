//
//  JCSRandQuoteController.h
//  RandQuotes
//
//  Created by Lambda_School_Loaner_95 on 4/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JCSRandQuote;
NS_SWIFT_NAME(QuoteController)
NS_ASSUME_NONNULL_BEGIN

@interface JCSRandQuoteController : NSObject

@property (nonatomic, readonly) NSArray<JCSRandQuote *> *quotes;
-(void)fetchQuotes: (void (^)(NSError *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
