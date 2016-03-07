//
//  CustomAlertViewDisplay.m
//  AlertView
//
//  Created by Ankur Batham on 11/12/15.
//  Copyright © 2015 Ankur Batham. All rights reserved.
//

#import "CustomAlertViewDisplay.h"


@implementation CustomAlertViewDisplay

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithAlertConfig:(CustomAlertConfig*)alertConfig
{
    alertViewConfig=alertConfig;
    
    self = [super init];
    if (self) {
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageTextView];
        UIView *buttonContainer = [UIView new];
        
        NSMutableDictionary *mutableViews = [NSMutableDictionary dictionaryWithDictionary:@{@"_titleLabel" : _titleLabel, @"_messageTextView" : _messageTextView, @"buttonContainer" : buttonContainer}];
        
        
        // Handle if no title or messages, give 0 margins
        NSNumber *titleMargin = alertViewConfig.title.length > 0 ? @24 : @0;
        NSNumber *msgMargin = alertViewConfig.message.length > 0 ? @24 : @0;
        
        if (titleMargin.floatValue > 0) {
            self.sectionCount++;
        }
        
        if (msgMargin.floatValue > 0) {
            self.sectionCount++;
        }
        
        NSDictionary *metrics = @{@"lblHMargin" : alertViewConfig.subviewsHorigentalMargin,
                                   @"topVMargin" : titleMargin,
                                   @"msgVMargin" : msgMargin,
                                   @"msgBottomMargin" : alertViewConfig.messageBottomMargin,
                                   @"btnTopMargin" : @(alertViewConfig.buttonMarginEdgeInsets.top),
                                   @"btnLeftMargin" : @(alertViewConfig.buttonMarginEdgeInsets.left),
                                   @"btnBottomMargin" : @(alertViewConfig.buttonMarginEdgeInsets.bottom),
                                   @"btnRightMargin" : @(alertViewConfig.buttonMarginEdgeInsets.right),
                                   @"btnVInterval" : @(alertViewConfig.buttonMarginEdgeInsets.top),
                                   @"btnH" : alertViewConfig.buttonHeight,
                                   };
        
        
        for (UIView *lbl in @[self.titleLabel, self.messageTextView]) {
            lbl.translatesAutoresizingMaskIntoConstraints = NO;
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-lblHMargin-[lbl]-lblHMargin-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(lbl)]];
        }
        
        buttonContainer.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSMutableArray *btns = [NSMutableArray new];
        
        
        [alertViewConfig.buttonArray enumerateObjectsUsingBlock:^(NSDictionary *action, NSUInteger idx, BOOL *stop) {
            
            NSLog(@"%@",action);
            
                UIButton *btn = [self createAlertViewButtonWithAction:[action[@"index"] integerValue] withTitle:action[@"title"]];
                [buttonContainer addSubview:btn];
                [btns addObject:btn];
        }];        
        
        
        [self addSubview:buttonContainer];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topVMargin-[_titleLabel]-msgVMargin-[_messageTextView]-msgBottomMargin-[buttonContainer]|" options:0 metrics:metrics views:mutableViews]];
        
        
        // Button Constraints
        self.buttons = [btns copy];
        self.sectionCount++;
        if (self.buttons.count == 1) {
            [buttonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-btnLeftMargin-[btnOne]-btnRightMargin-|" options:0 metrics:metrics views:@{@"btnOne" : self.buttons.firstObject}]];
            [buttonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-btnTopMargin-[btnOne(btnH)]-btnBottomMargin-|" options:0 metrics:metrics views:@{@"btnOne" : self.buttons.firstObject}]];
        }
        else if (self.buttons.count == 2 && !alertViewConfig.useVerticalLayoutForTwoButtons.boolValue ) {
            [buttonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-btnLeftMargin-[btnOne]-btnRightMargin-[btnTwo(==btnOne)]-btnRightMargin-|" options:0 metrics:metrics views:@{@"btnOne" : self.buttons.firstObject, @"btnTwo" : self.buttons[1]}]];
            [buttonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-btnTopMargin-[btnOne(btnH)]-btnBottomMargin-|" options:0 metrics:metrics views:@{@"btnOne" : self.buttons.firstObject}]];
            [buttonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-btnTopMargin-[btnTwo(btnH)]-btnBottomMargin-|" options:0 metrics:metrics views:@{@"btnTwo" : self.buttons[1]}]];
        }
        else {
            NSMutableDictionary *viewsDictionary = [NSMutableDictionary new];
            NSMutableString *verticalConstraintsFormat = [NSMutableString stringWithString:@"V:|"];
            for (int i = 0; i < self.buttons.count; i++) {
                NSString *buttonName = [NSString stringWithFormat:@"btn%d", i];
                [viewsDictionary setValue:self.buttons[i] forKey:buttonName];
                if (i == 0) {
                    [verticalConstraintsFormat appendString:@"-btnTopMargin-"];
                }
                else {
                    [verticalConstraintsFormat appendString:@"-btnVInterval-"];
                }
                [verticalConstraintsFormat appendFormat:@"[%@(btnH)]", buttonName];
                [buttonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-btnLeftMargin-[button]-btnRightMargin-|" options:0 metrics:metrics views:@{@"button" : self.buttons[i]}]];
            }
            if (self.buttons.count) {
                [verticalConstraintsFormat appendString:@"-btnBottomMargin-|"];
                [buttonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintsFormat options:0 metrics:metrics views:viewsDictionary]];
            }
            
        }
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[buttonContainer]|" options:0 metrics:metrics views:mutableViews]];
    }
    
    return self;
}

- (void)layoutSubviews {
    [self.messageTextView sizeToFit];
    [self.messageTextView layoutIfNeeded];
    
    CGFloat buttonHeight = self.buttons.count == 0 ? 0 : alertViewConfig.buttonHeight.floatValue;
    CGFloat numberOfVerticalButtons;
    
    if (self.buttons.count == 2 && !alertViewConfig.useVerticalLayoutForTwoButtons.boolValue) {
        numberOfVerticalButtons = 1;
    }
    else {
        numberOfVerticalButtons = self.buttons.count;
    }
    
    CGFloat screenHeight = SCREEN_HEIGHT;
    
    // Need this check because before iOS 8 screen.bounes.size is NOT orientation dependent
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((SYSTEM_VERSION_LESS_THAN(@"8.0")) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        screenHeight = screenSize.width;
    }
    
    CGFloat verticalSectionMarginsHeight = (24.0 * self.sectionCount);
    CGFloat buttonsHeight = (buttonHeight * numberOfVerticalButtons);
    CGFloat maxHeight = screenHeight - self.titleLabel.intrinsicContentSize.height - verticalSectionMarginsHeight  - buttonsHeight- kAlertViewHeightPadding;
    
    
    if(!self.messageTextView.heightLayoutConstraint)
        [self.messageTextView addConstraintForAttribute:NSLayoutAttributeHeight withItem:nil withConstant:0 withPriority:UILayoutPriorityRequired];
    
    if (self.messageTextView.text.length > 0) {
        if (self.messageTextView.contentSize.height > maxHeight) {
            self.messageTextView.heightLayoutConstraint.constant = maxHeight;
            self.messageTextView.scrollEnabled = YES;
        }
        else {
            self.messageTextView.heightLayoutConstraint.constant = self.messageTextView.contentSize.height;
        }
    }
    
    [super layoutSubviews];
    
    self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.frame.size.width;
    
    self.layer.cornerRadius = alertViewConfig.alertCornerRadius.floatValue;
    self.backgroundColor=alertViewConfig.alertBackgroundColor;
    self.layer.shadowColor = alertViewConfig.alertViewShadowColor.CGColor;
    self.layer.shadowOffset = alertViewConfig.alertShadowOffset;
    self.layer.shadowOpacity = alertViewConfig.alertViewShadowOpacity.floatValue;
    self.layer.shadowRadius = alertViewConfig.alertViewShadowRadius.floatValue;
}


#pragma mark - Getters
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.textAlignment = alertViewConfig.titleAlignment;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.font = alertViewConfig.titleFont;
        _titleLabel.textColor = alertViewConfig.titleColor;
        _titleLabel.text = alertViewConfig.title;
    }
    
    return _titleLabel;
}

- (UITextView *)messageTextView {
    if (!_messageTextView) {
        _messageTextView = [UITextView new];
        _messageTextView.backgroundColor = [UIColor clearColor];
        _messageTextView.font = alertViewConfig.messageFont;
        _messageTextView.textColor = alertViewConfig.messageColor;
        _messageTextView.text = alertViewConfig.message;
        _messageTextView.textAlignment = alertViewConfig.messageAlignment;
        _messageTextView.scrollEnabled = NO;
        _messageTextView.editable = NO;
        [_messageTextView setContentInset:UIEdgeInsetsZero];
        [_messageTextView scrollRangeToVisible:NSMakeRange(0, 0)];
    }
    
    return _messageTextView;
}

- (UIButton *)createAlertViewButtonWithAction:(NSInteger)index withTitle:(NSString*)title {
    
    UIColor *bgColor = alertViewConfig.buttonBackGroundColor;
    UIColor *titleColor = alertViewConfig.buttontitleColor;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    btn.backgroundColor = bgColor;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btn.layer.cornerRadius = alertViewConfig.buttonCornerRadius.floatValue;
    btn.layer.borderColor = alertViewConfig.buttonBorderColor.CGColor;
    btn.layer.borderWidth= alertViewConfig.buttonBorderwidth.floatValue;
    btn.tag = index;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}


- (void)buttonTouch:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%ld",(long)btn.tag);
    alertViewConfig.completionBlock(YES, btn.tag);
    
    
}



@end
