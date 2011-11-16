//
//  UINavigationController+CustomNavBar.m
//  CustomNavigationBarController
//
//  Created by LiJian Qiu on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UINavigationController+CustomNavBar.h"
#import "CustomNavigationBar.h"

static NSString* const kIBCustomNavigationController = @"CustomNavigationBarController";

@implementation UINavigationController (CustomNavBar)

-(id)initCustomNavBarWithRoot:(UIViewController *)root backgroundColor:(UIColor *)color;{
  UINavigationController *navigationController = nil;
  
//  available in ios 4.0+
//  UINib *nib = [UINib nibWithNibName:kIBCustomNavigationController bundle:nil];
//  navigationController = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
  
//  available in ios 3.0+  
    navigationController = [[[NSBundle mainBundle] 
                          loadNibNamed:kIBCustomNavigationController 
                          owner:nil options:nil] objectAtIndex:0];
  
  [(CustomNavigationBar *)navigationController.navigationBar setCustomColor:color];
  [navigationController pushViewController:root animated:NO];
  
  return navigationController;
}

-(id)initCustomNavBarWithRoot:(UIViewController *)root backgroundColor:(UIColor *)bgColor barButtonItemColor:(UIColor *)bbiColor{
  UINavigationController *navigationController = nil;
  
//  available in ios 4.0+
//  UINib *nib = [UINib nibWithNibName:kIBCustomNavigationController bundle:nil];
//  navigationController = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
  
//  available in ios 3.0+  
    navigationController = [[[NSBundle mainBundle] 
                           loadNibNamed:kIBCustomNavigationController 
                           owner:nil options:nil] objectAtIndex:0];
  [(CustomNavigationBar *)navigationController.navigationBar setCustomColor:bgColor];
  [navigationController.navigationBar setTintColor:bbiColor];
  [navigationController pushViewController:root animated:NO];
  
  return navigationController;
}

@end
