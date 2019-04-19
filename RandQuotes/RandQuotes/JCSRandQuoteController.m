//
//  JCSRandQuoteController.m
//  RandQuotes
//
//  Created by Lambda_School_Loaner_95 on 4/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import "JCSRandQuoteController.h"
#import "JCSRandQuote.h"

static NSString *baseURLString = @"https://andruxnet-random-famous-quotes.p.rapidapi.com/?cat=famous&count=1";

@interface JCSRandQuoteController ()

@property NSMutableArray *internalQuotes;

@end

@implementation JCSRandQuoteController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalQuotes = [[NSMutableArray alloc] init];
    }
    return self;
}




- (void)fetchQuotes:(void (^)(NSError * _Nullable))completion {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:baseURL];
    [request addValue:@"andruxnet-random-famous-quotes.p.rapidapi.com" forHTTPHeaderField:@"X-RapidAPI-Host"];
    [request addValue:@"b0db17e828mshf7339e5ba66df76p19b159jsn3c579973e3f4" forHTTPHeaderField:@"X-RapidAPI-Key"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching quotes: %@", error);
            completion(error);
            return;
        }
        
        NSError *jsonError;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!array) {
            NSLog(@"Error decode: %@", error);
            completion(error);
            return;
        }
        
        NSMutableArray *quotes = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in array) {
            JCSRandQuote *quote = [[JCSRandQuote alloc] initWithDictionary:dict];
            [quotes addObject:quote];
        }
        self.internalQuotes = quotes;
        NSLog(@"Quotes within the fetch: %@", quotes);
        completion(nil);
    
    }];
    [task resume];
}
- (NSArray<JCSRandQuote *> *)quotes {
    return self.internalQuotes;
}

@end
