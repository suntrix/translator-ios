//
//  WDSTranslator+UITextView.m
//  Translator
//
//  Created by Jacek Wierzbicki-Woś on 15/08/2013.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator+UITextView.h"

#import <UIKit/UIKit.h>

@implementation WDSTranslator (UITextView)

- (void)translateTextView:(UITextView *)textView toLanguage:(NSString *)language
{
    textView.text = [self translate:textView.text toLanguage:language];
}

- (void)translateTextView:(UITextView *)textView
{
    [self translateTextView:textView toLanguage:self.translationsLanguageCode];
}

- (void)translateTextViews:(NSArray *)textViews toLanguage:(NSString *)language
{
    NSMutableArray *texts = [NSMutableArray array];
    
    [textViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [texts insertObject:((UITextView*)obj).text atIndex:idx];
    }];
    
    NSArray *translatedTexts = [self translateMany:texts toLanguage:language];
    
    [textViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UITextView*)obj).text = translatedTexts[idx];
    }];
}

- (void)translateTextViews:(NSArray *)textViews
{
    [self translateTextViews:textViews toLanguage:self.translationsLanguageCode];
}

@end