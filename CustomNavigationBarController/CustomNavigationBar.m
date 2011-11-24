//
//  CustomNavigationBar.m
//  CustomNavigationBarController
//
//  Created by LiJian Qiu on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomNavigationBar.h"
#import "UIColor+Additions.h"


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

@synthesize customColor;
@synthesize customStyle;

-(id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    customColor = [[UIColor clearColor] retain];
    customStyle = CustomNavigationColor;
  }
  return self;
}

-(void)dealloc{
  [customColor release], customColor = nil;
}

-(void)drawRect:(CGRect)rect{
  [super drawRect:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();

  switch (customStyle) {
    case CustomNavigationColor:{
      CGContextSetFillColorWithColor(context, customColor.CGColor);
      CGContextFillRect(context, rect);
    }break;
    
    case CustomNavigationLinearGradient:{
      drawGlossAndGradient(context,rect,[customColor highlight].CGColor,customColor.CGColor);
    }break;    
    case CustomNavigationImage:{
    
    }break;
  }
}

@end
