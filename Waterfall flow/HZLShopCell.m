//
//  HZLShopCell.m
//  Waterfall flow
//
//  Created by 黄梓伦 on 3/17/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLShopCell.h"

@interface HZLShopCell()

@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation HZLShopCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //添加子控件
        UILabel *textLabel = [[UILabel alloc] init];
        self.textLabel = textLabel;
        
        self.textLabel.text = @"hehe";
        [self.contentView addSubview:textLabel];
        
    }
    
    return self;
}


- (void)setTextName:(NSString *)textName
{
    _textName = textName;
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:10];
    self.textLabel.frame = CGRectMake(0, 0, 30, 30);
    [self settingData];
    
    
}

- (void)settingData
{
    self.textLabel.text = self.textName;
}







@end
