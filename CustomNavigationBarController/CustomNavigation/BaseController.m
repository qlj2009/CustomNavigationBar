//
//  RootViewController.m
//  CustomNavigationBarController
//
//  Created by Qiu Lijian on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseController.h"
#import "CustomNavigationBar.h"

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Get our custom nav bar
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    
    if (!self.navigationItem.leftBarButtonItem.customView && [[self.navigationController viewControllers] objectAtIndex:0] != self ) 
    {
        // Set the nav bar's background
//        [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"nav_bar"]];
        // Create a custom back button
        UIButton  *backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"Back_Btn.png"] 
                                                         highlight:[UIImage imageNamed:@"Back_Btn_Clicked.png"]];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    }
}

@end


@implementation BaseTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Get our custom nav bar
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    
    if (!self.navigationItem.leftBarButtonItem.customView && [[self.navigationController viewControllers] objectAtIndex:0] != self ) 
    {
        // Set the nav bar's background
//        [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"nav_bar"]];
        // Create a custom back button
        UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"Back_Btn.png"] 
                                                         highlight:[UIImage imageNamed:@"Back_Btn_Clicked.png"]];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
        
    }
}

@end
