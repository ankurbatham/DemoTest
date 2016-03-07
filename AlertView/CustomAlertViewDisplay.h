//
//  CustomAlertViewDisplay.h
//  AlertView
//
//  Created by Ankur Batham on 11/12/15.
//  Copyright © 2015 Ankur Batham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertConfig.h"
#import "UIView+NSLayoutHelper.h"

#define TITLE @"The Title of my message can be up to 2 lines long. It wraps and centers."
#define MESSAGE @"You can change the fonts, colors, button size, corner radius, and much more.You can change the fonts, colors, button size, corner radius, and much more.You can change the fonts, colors, button size,."


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_RECT [[UIScreen mainScreen] bounds]

#define SCREEN_SCALE [[UIScreen mainScreen] scale]
#pragma mark - System Version
#define VERSION_GREATER_THAN(v1, v2)               ([v1 compare:v2 options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_EQUAL_TO(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

static NSInteger const kAlertViewHeightPadding = 80.f;

@interface CustomAlertViewDisplay : UIView {
    CustomAlertConfig *alertViewConfig;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *messageTextView;
@property (nonatomic, copy) NSArray *buttons;
@property (nonatomic, assign) NSInteger sectionCount;
- (instancetype)initWithAlertConfig:(CustomAlertConfig*)alertConfig;
- (UIButton *)createAlertViewButtonWithAction:(NSInteger)index withTitle:(NSString*)title;
@end
