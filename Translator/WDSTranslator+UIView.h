//
//  WDSTranslator+UIView.h
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator.h"

@class UIView;

@interface WDSTranslator (UIView)

- (void)translateView:(UIView *)view toLanguage:(NSString *)language;

- (void)translateView:(UIView *)view;

- (void)translateView:(UIView *)view onlySubviewsWithTags:(NSArray *)tags toLanguage:(NSString *)language;

- (void)translateView:(UIView *)view onlySubviewsWithTags:(NSArray *)tags;

@end
