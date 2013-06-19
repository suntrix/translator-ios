//
//  WDSTranslator.h
//  WDSTranslator
//
//  Created by Sebastian Owodziń on 6/18/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDSTranslator : NSObject

@property (strong, nonatomic) NSString *translationsLanguageCode; ///< default translation language code, used when invoking translation method without language argument

/**
 Gets translator instance
 @return WDSTranslator
 */
+ (WDSTranslator *)sharedObject;

/**
 Sets default translation language code using NSLocale object
 @param NSLocale locale
 */
- (void)setTranslationsLanguageCodeFromLocale:(NSLocale *)locale;

/**
 Translates the given text using default language
 @param NSString text
 @return NSString
 */
- (NSString *)translate:(NSString *)text;

/**
 Translates the given text using given language
 @param NSString text
 @param NSString language
 @return NSString
 */
- (NSString *)translate:(NSString *)text toLanguage:(NSString *)language;

/**
 Translates the given text array using default language
 @param NSArray texts
 @return NSArray
 */
- (NSArray *)translateMany:(NSArray *)texts;

/**
 Translates the given text array using given language
 @param NSArray texts
 @param NSString language
 @return NSArray
 */
- (NSArray *)translateMany:(NSArray *)texts toLanguage:(NSString *)language;

/**
 Loads translations for the given languages into in-memory cache
 @param NSArray languages
 */
- (void)loadTranslations:(NSArray *)languages;

/**
 Removes all cached translations from memory
 */
- (void)clearCache;

@end
