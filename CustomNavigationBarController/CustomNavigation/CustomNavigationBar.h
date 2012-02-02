//
//  CustomNavigationBar.h
//  CustomNavigationBarController
//
//  Created by LiJian Qiu on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum 
{
  CustomNavigationColor = 0,
  CustomNavigationLinearGradient,
  CustomNavigationImage
}CustomNavigationStyle;


@interface CustomNavigationBar : UINavigationBar{
  
  CGFloat barButtonCapWidth;
  IBOutlet UINavigationController* navigationController;
  
}
@property(nonatomic)CustomNavigationStyle customStyle;
@property(nonatomic, retain) IBOutlet UINavigationController* navigationController;
@property(nonatomic, retain)UIImageView *navigationBarBackgroundImage;

@property(nonatomic, retain)UIColor *navigationBarBackgroundColor;

-(void)setBackgroundWith:(UIImage*)backgroundImage;
-(void)clearBackground;

-(void) setText:(NSString*)text onBarButton:(UIButton*)barButton;
-(UIButton*)barButtonWith:(UIImage*)barButtonImage highlight:(UIImage*)barButtonHighlightImage 
             leftCapWidth:(CGFloat)capWidth title:(NSString *)title;
-(UIButton*)barButtonWith:(UIImage*)barButtonImage highlight:(UIImage*)barButtonHighlightImage title:(NSString *)title;
-(UIButton*)barButtonWith:(UIImage*)barButtonImage highlight:(UIImage*)barButtonHighlightImage leftCapWidth:(CGFloat)capWidth;
-(UIButton*)barButtonWith:(UIImage*)barButtonImage highlight:(UIImage*)barButtonHighlightImage;

-(UIButton*)backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage
              leftCapWidth:(CGFloat)capWidth title:(NSString *)title;
-(UIButton*)backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage title:(NSString *)title;
-(UIButton*)backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage leftCapWidth:(CGFloat)capWidth;
-(UIButton*)backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage;

@end
