//
//  JCSRandQuote.h
//  RandQuotes
//
//  Created by Lambda_School_Loaner_95 on 4/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Quote)
NS_ASSUME_NONNULL_BEGIN

@interface JCSRandQuote : NSObject

-(instancetype)initWithQuote:(NSString *)quote author:(NSString *)author;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *quote;
@property (nonatomic, copy) NSString *author;

@end

NS_ASSUME_NONNULL_END
