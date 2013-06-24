//
//  WDSTranslator+UILabel.h
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator.h"

@class UILabel;

@interface WDSTranslator (UILabel)

- (void)translateLabel:(UILabel *)label toLanguage:(NSString *)language;

- (void)translateLabel:(UILabel *)label;

- (void)translateLabels:(NSArray *)labels toLanguage:(NSString *)language;

- (void)translateLabels:(NSArray *)labels;

@end
