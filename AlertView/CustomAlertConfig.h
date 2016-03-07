//
//  CustomAlertConfig.h
//  AlertView
//
//  Created by Ankur Batham on 10/12/15.
//  Copyright © 2015 Ankur Batham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^AlertViewButtonTouched)(BOOL action, NSInteger idx);

@interface CustomAlertConfig : NSObject

/** Alert Title Properties
 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) NSTextAlignment titleAlignment;

/**
 *  Alert Message Properties
 */
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIFont *messageFont;
@property (nonatomic, assign) NSTextAlignment messageAlignment;
@property (nonatomic, strong) NSNumber *messageBottomMargin;

/**
 *  Array of actions added to the alert and button properties
 */
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSNumber *buttonCornerRadius;
@property (nonatomic, strong) NSNumber *buttonHeight;
@property (nonatomic, assign) UIEdgeInsets buttonMarginEdgeInsets;
@property (nonatomic, strong) NSNumber *buttonHorizontalMargin;
@property (nonatomic, strong) UIColor *buttonBackGroundColor;
@property (nonatomic, strong) UIColor *buttontitleColor;
@property (nonatomic, strong) UIColor *buttonBorderColor;
@property (nonatomic, strong) NSNumber *buttonBorderwidth;
@property (nonatomic, copy) AlertViewButtonTouched completionBlock;
/**
 * Alert View properties
 */
@property (nonatomic, strong) UIColor *alertBackgroundColor;
@property (nonatomic, strong) NSNumber *alertCornerRadius;
@property (nonatomic, strong) NSNumber *alertViewShadowOpacity;
@property (nonatomic, strong) NSNumber *alertViewShadowRadius;
@property (nonatomic, strong) UIColor *alertViewShadowColor;
@property (nonatomic, assign) CGSize alertShadowOffset;

/**
 * Alert View Controller properties
 */
@property (nonatomic, strong) UIColor *backgroundViewTintColor;
@property (nonatomic, strong) NSNumber *blurEnabled;

/**
 *  Boolean flag if to use vertical layout for 2 buttons
 */
@property (nonatomic, strong) NSNumber *useVerticalLayoutForTwoButtons;

/**
 *  Flag if the alert is active.
 */
@property (nonatomic, assign) BOOL isActiveAlert;

/**
 * alert view's sub views horigental margin
 */
@property (nonatomic, strong) NSNumber *subviewsHorigentalMargin;

@property(nonatomic, strong)UIView *presentView;


@end
