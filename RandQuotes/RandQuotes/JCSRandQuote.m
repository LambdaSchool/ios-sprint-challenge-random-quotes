//
//  JCSRandQuote.m
//  RandQuotes
//
//  Created by Lambda_School_Loaner_95 on 4/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import "JCSRandQuote.h"

@implementation JCSRandQuote

- (instancetype)initWithQuote:(NSString *)quote author:(NSString *)author {
    self = [super init];
    if (self) {
        _quote = quote;
        _author = author;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *quote = dictionary[@"quote"];
    NSString *author = dictionary[@"author"];
    
    return [self initWithQuote:quote author:author];
}

@end
