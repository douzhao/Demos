//
//  IconEdgeInsetsLabel.m
//  EdgeInsetLabel
//
//  Created by YouXianMing on 16/6/22.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "IconEdgeInsetsLabel.h"

@interface IconEdgeInsetsLabel ()

@property (nonatomic, weak) UIView  *oldIconView;

@end

@implementation IconEdgeInsetsLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    UIEdgeInsets insets = self.edgeInsets;
    
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets) limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.height += (insets.top + insets.bottom);
    _iconView && [_iconView isKindOfClass:[UIView class]] ?
    (rect.size.width += (insets.left + insets.right + _gap + _iconView.frame.size.width)) :
    (rect.size.width += (insets.left + insets.right));

    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    
    UIEdgeInsets insets = self.edgeInsets;
    
    if (self.iconView) {
        
        if (self.direction == kIconAtLeft) {

            CGRect iconViewFrame = _iconView.frame;
            iconViewFrame.origin.x    = insets.left;
            _oldIconView.frame = iconViewFrame;
            
            CGPoint iconViewCenter = _iconView.center;
            iconViewCenter.y = self.center.y/2.0;
            _iconView.center = iconViewCenter;
            
            insets = UIEdgeInsetsMake(insets.top, insets.left + _gap + _iconView.frame.size.width, insets.bottom, insets.right);
            
        } else if (self.direction == kIconAtRight) {
        
            CGRect iconViewFrame = _iconView.frame;
            iconViewFrame.origin.x = insets.right;
            _oldIconView.frame = iconViewFrame;
            
            CGPoint iconViewCenter = _iconView.center;
            iconViewCenter.y = self.center.y/2.0;
            _iconView.center = iconViewCenter;
            
            insets = UIEdgeInsetsMake(insets.top, insets.left, insets.bottom, insets.right  + _gap + _iconView.frame.size.width);
        }
    }
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (void)sizeToFitWithText:(NSString *)text {

    self.text = text;
    [self sizeToFit];
}

#pragma mark - setter & getter.

@synthesize iconView = _iconView;

- (void)setIconView:(UIView *)iconView {

    _oldIconView && [_oldIconView isKindOfClass:[UIView class]] ? ([_oldIconView removeFromSuperview]) : 0;
    
    _iconView    = iconView;
    _oldIconView = iconView;
    
    [self addSubview:iconView];
}

- (UIView *)iconView {

    return _iconView;
}

@end
