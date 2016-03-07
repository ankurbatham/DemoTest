//
//  CustomAlertConfig.m
//  AlertView
//
//  Created by Ankur Batham on 10/12/15.
//  Copyright © 2015 Ankur Batham. All rights reserved.
//

#import "CustomAlertConfig.h"

@implementation CustomAlertConfig


#pragma mark - Title
- (UIColor *)titleColor {
    return _titleColor ?: [UIColor blackColor];
}

- (UIFont *)titleFont {
    return _titleFont ?: [UIFont boldSystemFontOfSize:14];
}

- (NSTextAlignment)titleAlignment {
    return _titleAlignment ?: NSTextAlignmentCenter;
}

#pragma mark - Message
- (UIColor *)messageColor {
    return _messageColor ?: [UIColor blackColor];
}

- (UIFont *)messageFont {
    return _messageFont ?: [UIFont systemFontOfSize:14];
}

- (NSTextAlignment)messageAlignment {
    return _messageAlignment ?: NSTextAlignmentCenter;
}

-(NSNumber*)messageBottomMargin{
    
    return _messageBottomMargin? : @8;
}


#pragma mark - Buttons
- (NSNumber *)useVerticalLayoutForTwoButtons {
    return _useVerticalLayoutForTwoButtons ?: @0;
}

- (NSNumber *)buttonCornerRadius {
    return _buttonCornerRadius ?: @8;
}

- (NSNumber *)buttonHeight {
    return _buttonHeight ?: @44;
}

- (NSNumber *)buttonHorizontalMargin {
    return _buttonHorizontalMargin ?: @8;
}

- (UIEdgeInsets)buttonMarginEdgeInsets {
    
    return UIEdgeInsetsMake(self.buttonHorizontalMargin.floatValue, self.buttonHorizontalMargin.floatValue, self.buttonHorizontalMargin.floatValue, self.buttonHorizontalMargin.floatValue);
}

-(UIColor*)buttonBackGroundColor{
    return _buttonBackGroundColor ? :[UIColor clearColor];
}

-(UIColor*)buttontitleColor{
    return _buttontitleColor ? :[UIColor blueColor];
}

-(UIColor*)buttonBorderColor{
    return _buttonBorderColor ? :[UIColor blueColor];
}

- (NSNumber *)buttonBorderwidth {
    return _buttonBorderwidth ?: @1.0;
}

#pragma mark - Alert View
- (NSNumber *)alertCornerRadius {
    return _alertCornerRadius ?: @8;
}
- (UIColor *)alertBackgroundColor {
    return _alertBackgroundColor ?: [UIColor whiteColor];
}

-(NSNumber*)subviewsHorigentalMargin {
    return _subviewsHorigentalMargin ?: @10;
}
- (NSNumber *)alertViewShadowRadius {
    return _alertViewShadowRadius ?: @2;
}

- (NSNumber *)alertViewShadowOpacity {
    return _alertViewShadowOpacity ?: @0.3f;
}

- (UIColor *)alertViewShadowColor {
    return _alertViewShadowColor ?: [UIColor blackColor];
}

- (CGSize)alertShadowOffset {
    return CGSizeEqualToSize(_alertShadowOffset, CGSizeZero) ? CGSizeMake(1, 1) : _alertShadowOffset;
}

#pragma mark - Blur / Background View

-(UIColor*)backgroundViewTintColor{
    return _backgroundViewTintColor ?: [UIColor whiteColor];
}

- (NSNumber *)blurEnabled {
    return _blurEnabled ?: @YES;
}
@end
