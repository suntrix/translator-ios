//
//  WDSTranslator+UIView.h
//  Translator
//
//  Created by Sebastian Owodziń on 6/20/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "WDSTranslator.h"

#import "WDSTranslator+UILabel.h"
#import "WDSTranslator+UIButton.h"
#import "WDSTranslator+UITextField.h"

@class UIView;

@interface WDSTranslator (UIView)

- (void)translateView:(UIView *)viewObject;

- (void)translateView:(UIView *)viewObject toLanguage:(NSString *)language;

@end
