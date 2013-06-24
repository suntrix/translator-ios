//
//  WDSTranslator+UILabel.m
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator+UILabel.h"

#import <UIKit/UIKit.h>

@implementation WDSTranslator (UILabel)

- (void)translateLabel:(UILabel *)label toLanguage:(NSString *)language
{
    label.text = [self translate:label.text toLanguage:language];
}

- (void)translateLabel:(UILabel *)label
{
    [self translateLabel:label toLanguage:self.translationsLanguageCode];
}

- (void)translateLabels:(NSArray *)labels toLanguage:(NSString *)language
{
    NSMutableArray *texts = [NSMutableArray array];
    
    [labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [texts insertObject:((UILabel*)obj).text atIndex:idx];
    }];
    
    NSArray *translatedTexts = [self translateMany:texts toLanguage:language];
    
    [labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UILabel *)obj).text = translatedTexts[idx];
    }];
}

- (void)translateLabels:(NSArray *)labels
{
    [self translateLabels:labels toLanguage:self.translationsLanguageCode];
}

@end
