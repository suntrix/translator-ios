//
//  MainViewController.m
//  ExampleApp
//
//  Created by Jacek Wierzbicki-Woś on 16/07/2013.
//  Copyright (c) 2013 WEB DESIGN STUDIO Sebastian Owodziń. All rights reserved.
//

#import "MainViewController.h"

#import "TranslationsViewController.h"
#import "WDSTranslator.h"

@interface MainViewController ()
{
    NSArray *   __tableData;
}

@end

@implementation MainViewController

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __tableData = @[
                    @{@"cellIdentifier" : @"SeparateTranslationsCellIdentifier", @"language" : @"pl"},
                    @{@"cellIdentifier" : @"SeparateTranslationsCellIdentifier", @"language" : @"fr"},
                    @{@"cellIdentifier" : @"FullViewTranslationCellIdentifier", @"language" : @"pl"},
                    @{@"cellIdentifier" : @"FullViewTranslationCellIdentifier", @"language" : @"fr"},
                    @{@"cellIdentifier" : @"FullViewTranslationWithTagsCellIdentifier", @"language" : @"pl"},
                    @{@"cellIdentifier" : @"FullViewTranslationWithTagsCellIdentifier", @"language" : @"fr"}
                    ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [@[@"->SeparateTranslations", @"->FullViewTranslation", @"->FullViewTranslationWithTags"] containsObject:segue.identifier] )
    {
        WDSTranslator *translator = [WDSTranslator sharedObject];
        translator.translationsLanguageCode = __tableData[[self.tableView indexPathForSelectedRow].row][@"language"];
        
        TranslationsViewController *viewController = (TranslationsViewController *)segue.destinationViewController;
        
        if ( [segue.identifier isEqualToString:@"->SeparateTranslations"] )
        {
            viewController.mode = TranslationsViewControllerModeSeparated;
            viewController.title = @"Separate Translations";
        }
        else if ( [segue.identifier isEqualToString:@"->FullViewTranslation"] )
        {
            viewController.mode = TranslationsViewControllerModeFullView;
            viewController.title = @"Full View Translations";
        }
        else if ( [segue.identifier isEqualToString:@"->FullViewTranslationWithTags"] )
        {
            viewController.mode = TranslationsViewControllerModeFullViewTagsOnly;
            viewController.title = @"Full View Translations (Tags)";
        }
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [__tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:__tableData[indexPath.row][@"cellIdentifier"]];
    
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [__tableData[indexPath.row][@"language"] uppercaseString];
    
    return cell;
}

@end
