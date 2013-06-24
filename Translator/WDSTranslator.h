//
//  WDSTranslator.h
//  WDSTranslator
//
//  Created by Sebastian Owodziń on 6/18/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDSTranslator : NSObject

@property (strong, nonatomic) NSString *translationsLanguageCode;

+ (WDSTranslator *)sharedObject;

- (void)setTranslationsLanguageCodeFromLocale:(NSLocale *)locale;

- (NSString *)translate:(NSString *)text toLanguage:(NSString *)language;

- (NSString *)translate:(NSString *)text;

- (NSArray *)translateMany:(NSArray *)texts toLanguage:(NSString *)language;

- (NSArray *)translateMany:(NSArray *)texts;

- (void)loadTranslations:(NSArray *)languages;

- (void)clearCache;

@end
