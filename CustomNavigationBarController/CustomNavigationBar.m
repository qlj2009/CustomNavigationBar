//
//  CustomNavigationBar.m
//  CustomNavigationBarController
//
//  Created by LiJian Qiu on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

@synthesize customColor;

-(id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    customColor = [UIColor clearColor];
  }
  return self;
}

-(void)dealloc{
  [customColor release], customColor = nil;
}

-(void)drawRect:(CGRect)rect{
  [super drawRect:rect];
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, customColor.CGColor);
  CGContextFillRect(context, rect);
}

@end
