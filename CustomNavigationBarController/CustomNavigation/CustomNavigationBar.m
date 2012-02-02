//
//  CustomNavigationBar.m
//  CustomNavigationBarController
//
//  Created by LiJian Qiu on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomNavigationBar.h"
#import "UIColor+Additions.h"

#define MAX_BACK_BUTTON_WIDTH 160.0

static void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef  endColor) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGFloat locations[] = { 0.0, 1.0 };
  
  NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
  
  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);
  
  CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
  CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
  
  CGContextSaveGState(context);
  CGContextAddRect(context, rect);
  CGContextClip(context);
  CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
  CGContextRestoreGState(context);
  
  CGGradientRelease(gradient);
}

static void drawGlossAndGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor) {
  
  drawLinearGradient(context, rect, startColor, endColor);
  
  CGColorRef glossColor1 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35].CGColor;
  CGColorRef glossColor2 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
  
  CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);
  
  drawLinearGradient(context, topHalf, glossColor1, glossColor2);
}


@implementation CustomNavigationBar

@synthesize navigationController;
@synthesize navigationBarBackgroundColor;
@synthesize customStyle;
@synthesize navigationBarBackgroundImage;

-(id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self)
  {
    navigationBarBackgroundColor = [[UIColor clearColor] retain];
    customStyle = CustomNavigationColor;
    navigationBarBackgroundImage = nil;
  }
  return self;
}

-(void)dealloc
{
  [navigationBarBackgroundColor release], navigationBarBackgroundColor = nil;
  [navigationBarBackgroundImage release], navigationBarBackgroundImage = nil;
}

-(void)drawRect:(CGRect)rect{
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
  CGContextFillRect(context, rect);
  
  switch (customStyle)
  {
    case CustomNavigationColor:
    {
      CGContextSetFillColorWithColor(context, navigationBarBackgroundColor.CGColor);
      CGContextFillRect(context, rect);
    }
      break;
      
    case CustomNavigationLinearGradient:
    {
      drawGlossAndGradient(context,rect,[navigationBarBackgroundColor highlight].CGColor,navigationBarBackgroundColor.CGColor);
    }
      break;
      
    case CustomNavigationImage:
    {
      if (navigationBarBackgroundImage)
        [navigationBarBackgroundImage.image drawInRect:rect];
      else
        [super drawRect:rect];
    }
      break;
      
    default:
      break;
  }
}

// Save the background image and call setNeedsDisplay to force a redraw
-(void) setBackgroundWith:(UIImage*)backgroundImage
{
  self.navigationBarBackgroundImage = [[[UIImageView alloc] initWithFrame:self.frame] autorelease];
  navigationBarBackgroundImage.image = backgroundImage;
  [self setNeedsDisplay];
}


// clear the background image and call setNeedsDisplay to force a redraw
-(void) clearBackground
{
  self.navigationBarBackgroundImage = nil;
  [self setNeedsDisplay];
}

// With a custom back button, we have to provide the action. We simply pop the view controller
- (IBAction)back:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - BarButton with title and capWidth

// Given the prpoer images and cap width, create a variable width back button
-(UIButton*) barButtonWith:(UIImage*)barButtonImage highlight:(UIImage*)barButtonHighlightImage leftCapWidth:(CGFloat)capWidth title:(NSString *)title
{
  // store the cap width for use later when we set the text
  barButtonCapWidth = capWidth;
  
  UIImage *buttonImage;
  UIImage *buttonHighlightImage;
  
  // Create stretchable images for the normal and highlighted states
  buttonImage = (capWidth == 0)?barButtonImage:[barButtonImage stretchableImageWithLeftCapWidth:barButtonCapWidth 
                                                                                   topCapHeight:0.0];
  buttonHighlightImage = (capWidth == 0)?barButtonHighlightImage:[barButtonHighlightImage stretchableImageWithLeftCapWidth:barButtonCapWidth 
                                                                                                              topCapHeight:0.0];
  // Create a custom button
  UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
  
  // Make the button as high as the passed in image
  button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
  
  // Just like the standard back button, use the title of the previous item as the default back text
  //  [self setText:self.topItem.title onBackButton:button];
  if (title && ![title isEqualToString:@""]) {
    // Set the title to use the same font and shadow as the standard back button
    button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.shadowOffset = CGSizeMake(0,-1);
    button.titleLabel.shadowColor = [UIColor darkGrayColor];
    
    // Set the break mode to truncate at the end like the standard back button
    button.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
    // Inset the title on the left and right
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5.0, 0, 5.0);
    [self setText:title onBarButton:button];
  }
  
  // Set the stretchable images as the background for the button
  [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
  [button setBackgroundImage:buttonHighlightImage forState:UIControlStateHighlighted];
  [button setBackgroundImage:buttonHighlightImage forState:UIControlStateSelected];
  
  return button;
}


// Set the text on the custom bar button
-(void) setText:(NSString*)text onBarButton:(UIButton*)barButton
{
  // Measure the width of the text
  CGSize textSize = [text sizeWithFont:barButton.titleLabel.font];
  // Change the button's frame. The width is either the width of the new text or the max width
  barButton.frame = CGRectMake(barButton.frame.origin.x, barButton.frame.origin.y, (textSize.width + (barButtonCapWidth * 1.5)) > MAX_BACK_BUTTON_WIDTH ? MAX_BACK_BUTTON_WIDTH : (textSize.width + (barButtonCapWidth * 1.5)), barButton.frame.size.height);
  
  // Set the text on the button
  [barButton setTitle:text forState:UIControlStateNormal];
}


#pragma mark - BarButton with

-(UIButton*)barButtonWith:(UIImage*)barButtonImage highlight:(UIImage*)barButtonHighlightImage title:(NSString *)title
{
  return [self barButtonWith:barButtonImage highlight:barButtonHighlightImage leftCapWidth:30 title:title];
}

#pragma mark - BarButton without title

// Given the prpoer images and cap width, create a variable width back button
-(UIButton*)barButtonWith:(UIImage*)barButtonImage highlight:(UIImage*)barButtonHighlightImage leftCapWidth:(CGFloat)capWidth
{
  return [self barButtonWith:barButtonImage highlight:barButtonHighlightImage leftCapWidth:capWidth title:nil];  
}

#pragma mark - BarButton without title and leftCapWidth

// Given the prpoer images and cap width, create a variable width back button
-(UIButton*)barButtonWith:(UIImage*)barButtonImage highlight:(UIImage*)barButtonHighlightImage
{
  return [self barButtonWith:barButtonImage highlight:barButtonHighlightImage leftCapWidth:0 title:nil];  
}

#pragma mark - BackButton

-(UIButton*)backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage
              leftCapWidth:(CGFloat)capWidth title:(NSString *)title
{
  UIButton *backButton =  [self barButtonWith:backButtonImage 
                                    highlight:backButtonHighlightImage leftCapWidth:capWidth title:title];
  // Add an action for going back
  [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
  return backButton;
}

-(UIButton*)backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage title:(NSString *)title
{
  UIButton *backButton = [self barButtonWith:backButtonImage highlight:backButtonHighlightImage title:title];
  [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
  return backButton;
}

-(UIButton*)backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage leftCapWidth:(CGFloat)capWidth
{
  UIButton *backButton = [self barButtonWith:backButtonImage highlight:backButtonHighlightImage leftCapWidth:capWidth];
  [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
  return backButton;
}
-(UIButton*)backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage
{
  UIButton *backButton = [self barButtonWith:backButtonImage highlight:backButtonHighlightImage];
  [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
  return backButton;
}



@end
