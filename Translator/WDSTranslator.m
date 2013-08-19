//
//  WDSTranslator.m
//  WDSTranslator
//
//  Created by Sebastian Owodziń on 6/18/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator.h"

#define kWDSTranslatorTranslationsFilenamePattern @"translations_%@"

@interface WDSTranslator ()
{
    NSMutableDictionary *   __translationsCache;
}

- (void)__loadTranslationsIfNeeded:(NSString *)language;

- (BOOL)__translationsCached:(NSString *)language;

- (void)__loadTranslations:(NSString *)language;

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

- (NSString *)translate:(NSString *)text toLanguage:(NSString *)language
{
    [self __loadTranslationsIfNeeded:language];
    
    NSString *translation = __translationsCache[language][text];
    if ( nil == translation )
    {
        translation = text;
    }
    
    return translation;
}

- (NSString *)translate:(NSString *)text
{
    if ( nil == self.translationsLanguageCode )
    {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Translations default language code is not set! You need to set it, to use this method."];
    }
    
    return [self translate:text toLanguage:self.translationsLanguageCode];
}

- (NSArray *)translateMany:(NSArray *)texts toLanguage:(NSString *)language
{
    [self __loadTranslationsIfNeeded:language];
    
    NSMutableArray *translations = [NSMutableArray arrayWithArray:[__translationsCache[language] objectsForKeys:texts notFoundMarker:@"<!not-found!>"]];    
    [translations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj isEqualToString:@"<!not-found!>"] )
        {
            translations[idx] = texts[idx];
        }
    }];
    
    return translations;
}

- (NSArray *)translateMany:(NSArray *)texts
{
    if ( nil == self.translationsLanguageCode )
    {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Translations default language code is not set! You need to set it, to use this method."];
    }
    
    return [self translateMany:texts toLanguage:self.translationsLanguageCode];
}

- (void)loadTranslations:(NSArray *)languages
{
    for ( NSString *language in languages )
    {
        [self __loadTranslationsIfNeeded:language];
    }
}

- (void)clearCache:(BOOL)all
{
    if ( all )
    {
        [__translationsCache removeAllObjects];
    }
    else
    {
        NSMutableArray *keys = [NSMutableArray arrayWithArray:[__translationsCache allKeys]];
        [keys removeObject:self.translationsLanguageCode];
        
        [__translationsCache removeObjectsForKeys:keys];
    }
}

#pragma mark Inherited from NSObject

- (id)init
{
    self = [super init];
    if ( nil != self )
    {
        __translationsCache = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark Private methods

- (void)__loadTranslationsIfNeeded:(NSString *)language
{
    if ( NO == [self __translationsCached:language] )
    {
        [self __loadTranslations:language];
    }
}

- (BOOL)__translationsCached:(NSString *)language
{
    return [[__translationsCache allKeys] containsObject:language];
}

- (void)__loadTranslations:(NSString *)language
{
    NSString *filename = [NSString stringWithFormat:kWDSTranslatorTranslationsFilenamePattern, language];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:filename ofType:@"json"];
    BOOL usingJson = nil != path;
    
    if ( nil == path )
    {
        path = [[NSBundle bundleForClass:[self class]] pathForResource:filename ofType:@"plist"];
    }
    
    if ( nil == path )
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"Translations file for language %@ not found.", language];
    }
    
    if ( usingJson )
    {
        [__translationsCache addEntriesFromDictionary:@{language: (NSDictionary *)[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:0 error:nil]}];
    }
    else
    {
        [__translationsCache addEntriesFromDictionary:@{language: [NSDictionary dictionaryWithContentsOfFile:path]}];
    }
}

@end
