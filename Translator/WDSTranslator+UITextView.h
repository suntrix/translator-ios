//
//  WDSTranslator+UITextView.h
//  Translator
//
//  Created by Jacek Wierzbicki-Woś on 15/08/2013.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator.h"

@class UITextView;

@interface WDSTranslator (UITextView)

- (void)translateTextView:(UITextView *)textView toLanguage:(NSString *)language;

- (void)translateTextView:(UITextView *)textView;

- (void)translateTextViews:(NSArray *)textViews toLanguage:(NSString *)language;

- (void)translateTextViews:(NSArray *)textViews;

@end
