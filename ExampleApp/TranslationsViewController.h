//
//  TranslationsViewController.h
//  Translator
//
//  Created by Sebastian Owodziń on 8/19/13.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TranslationsViewControllerMode {
    TranslationsViewControllerModeSeparated = 1,
    TranslationsViewControllerModeFullView = 2,
    TranslationsViewControllerModeFullViewTagsOnly = 3
};

@interface TranslationsViewController : UIViewController

@property(assign, nonatomic) enum TranslationsViewControllerMode mode;

// used for separate translations
@property (strong, nonatomic) IBOutlet UILabel *translatedLabel;
@property (strong, nonatomic) IBOutlet UIButton *translatedButton;
@property (strong, nonatomic) IBOutlet UITextField *translatedTextField;
@property (strong, nonatomic) IBOutlet UITextView *translatedTextView;

@end
