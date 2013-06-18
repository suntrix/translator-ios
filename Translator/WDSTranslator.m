//
//  WDSTranslator.m
//  WDSTranslator
//
//  Created by Sebastian Owodziń on 6/18/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator.h"

#define kWDSTranslatorTranslationsFilenamePattern @"translations.%@"

@interface WDSTranslator ()
{
    NSMutableDictionary *   __translationsCache;
}

- (BOOL)__translationsCached:(NSString *)language;

- (void)__cacheTranslations:(NSString *)language;

@end

@implementation WDSTranslator

+ (WDSTranslator *)sharedObject
{
    static WDSTranslator *object;
    
    if ( nil == object )
    {
        @synchronized (self)
        {
            object = [[WDSTranslator alloc] init];
            assert(nil != object);
        }
    }
    
    return object;
}

- (void)setTranslationsLanguageCodeFromLocale:(NSLocale *)locale
{
    self.translationsLanguageCode = [locale objectForKey:NSLocaleLanguageCode];
}

- (NSString *)translate:(NSString *)text
{
    if ( nil == self.translationsLanguageCode )
    {
        [NSException raise:@"Translations default language is not set!"
                    format:@"You need to set it, to use this method."];
    }
    
    return [self translate:text toLanguage:self.translationsLanguageCode];
}

- (NSArray *)translateMany:(NSArray *)texts
{
    if ( nil == self.translationsLanguageCode )
    {
        [NSException raise:@"Translations default language is not set!"
                    format:@"You need to set it, to use this method."];
    }
    
    return [self translateMany:texts toLanguage:self.translationsLanguageCode];
}

- (NSString *)translate:(NSString *)text toLanguage:(NSString *)language
{
    if ( NO == [self __translationsCached:language] )
    {
        [self __cacheTranslations:language];
    }
    
    NSString *translation = [[__translationsCache objectForKey:language] objectForKey:text];
    if ( nil == translation )
    {
        translation = text;
    }
    
    return translation;
}

- (NSArray *)translateMany:(NSArray *)texts toLanguage:(NSString *)language
{
    if ( NO == [self __translationsCached:language] )
    {
        [self __cacheTranslations:language];
    }
    
    return [[__translationsCache objectForKey:language] objectsForKeys:texts notFoundMarker:@""];
}

- (void)loadTranslations:(NSArray *)languages
{
    for ( NSString *language in languages )
    {
        if ( NO == [self __translationsCached:language] )
        {
            [self __cacheTranslations:language];
        }
    }
}

- (void)clearCache
{
    [__translationsCache removeAllObjects];
}

#pragma mark Inherited from NSObject

- (id)init
{
    self = [super init];
    if ( nil != self )
    {
        __translationsCache = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark Private methods

- (BOOL)__translationsCached:(NSString *)language
{
    return [[__translationsCache allKeys] containsObject:language];
}

- (void)__cacheTranslations:(NSString *)language
{
    NSString *filename = [NSString stringWithFormat:kWDSTranslatorTranslationsFilenamePattern, language];
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:filename ofType:@"plist"];
    
    if ( nil == path )
    {
        [NSException raise:[NSString stringWithFormat:@"Translations file for language %@ not found!", language]
                    format:@"%@.plist file is missing or not readable.", filename];
    }
    
    [__translationsCache addEntriesFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [NSDictionary dictionaryWithContentsOfFile:path],
                                                   language,
                                                   nil]];
}

@end
