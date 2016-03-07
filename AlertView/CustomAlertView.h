//
//  CustomAlertView.h
//  AlertView
//
//  Created by Ankur Batham on 10/12/15.
//  Copyright © 2015 Ankur Batham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertConfig.h"

@interface CustomAlertView : UIViewController



/**
 *  Initialize with a title and/or message
 *
 *  @param title   Optional. The title text displayed in the alert
 *  @param message Optional. The message text displayed in the alert
 *
 *  @return A CustomAlertView ready to be configurated further or displayed
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message actionCompleted:(AlertViewButtonTouched)completionBlock;

/**
 *  The configuration object associated with this alert
 */
@property (nonatomic, strong) CustomAlertConfig *alertConfig;


- (void)show;

-(void)dismissAlert;


@end

