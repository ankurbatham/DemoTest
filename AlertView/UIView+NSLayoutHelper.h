//
//  UIView+NSLayoutHelper.h
//  AlertView
//
//  Created by Ankur Batham on 10/12/15.
//  Copyright © 2015 Ankur Batham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NSLayoutHelper)

- (NSLayoutConstraint *)heightLayoutConstraint;

- (NSLayoutConstraint *)addConstraintForAttribute:(NSLayoutAttribute)attribute withItem:(id)item withConstant:(CGFloat)constant withPriority:(UILayoutPriority)priority;
@end
