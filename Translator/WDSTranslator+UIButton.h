//
//  WDSTranslator+UIButton.h
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator.h"

@class UIButton;

@interface WDSTranslator (UIButton)

- (void)translateButton:(UIButton *)button toLanguage:(NSString *)language;

- (void)translateButton:(UIButton *)button;

@end
