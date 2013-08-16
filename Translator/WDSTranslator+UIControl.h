//
//  WDSTranslator+UIControl.h
//  Translator
//
//  Created by Sebastian Owodziń on 8/12/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator.h"

@class UIControl;

@interface WDSTranslator (UIControl)

- (void)translateControl:(UIControl *)control toLanguage:(NSString *)language;

- (void)translateControl:(UIControl *)control;

- (void)translateControls:(NSArray *)controls toLanguage:(NSString *)language;

- (void)translateControls:(NSArray *)controls;

@end
