//
//  CustomTableViewCell.m
//  CustomNavigationBarController
//
//  Created by Qiu LiJian on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      self.backgroundView = [UACellBackgroundView backgroundView];
      self.selectedBackgroundView = [UACellBackgroundView backgroundViewIsSelectedView:YES];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPosition:(UACellBackgroundViewPosition)newPosition {	
  [(UACellBackgroundView *)self.backgroundView setPosition:newPosition];
  [(UACellBackgroundView *)self.selectedBackgroundView setPosition:newPosition];
}

@end
