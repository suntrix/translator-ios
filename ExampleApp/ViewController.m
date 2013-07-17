//
//  ViewController.m
//  ExampleApp
//
//  Created by Jacek Wierzbicki-Woś on 16/07/2013.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "ViewController.h"

#import "WDSTranslator.h"

@interface ViewController ()
{
    NSArray *   __langs;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    __langs = @[@"pl", @"fr"];
    
    WDSTranslator *translator = [WDSTranslator sharedObject];
    
    translator.translationsLanguageCode = __langs[0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    WDSTranslator *translator = [WDSTranslator sharedObject];
    
    translator.translationsLanguageCode = __langs[item.tag];
}

@end
