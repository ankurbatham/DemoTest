//
//  UIView+NSLayoutHelper.m
//  AlertView
//
//  Created by Ankur Batham on 10/12/15.
//  Copyright © 2015 Ankur Batham. All rights reserved.
//

#import "UIView+NSLayoutHelper.h"
static NSString * Constraint_Identifier = @"Constraint.Identifier";


@implementation UIView (NSLayoutHelper)


#pragma mark - Height Constraints
- (NSLayoutConstraint *)heightLayoutConstraint {
    return [self urbn_constraintForAttribute:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)urbn_constraintForAttribute:(NSLayoutAttribute)attribute {
    NSMutableArray *predicates = [NSMutableArray array];
    [predicates addObject:[NSPredicate predicateWithFormat:@"firstItem == %@", self]];
    [predicates addObject:[NSPredicate predicateWithFormat:@"firstAttribute == %i", attribute] ];
    if ([[NSLayoutConstraint new] respondsToSelector:@selector(identifier)]) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"identifier == %@", Constraint_Identifier]];
    }
    NSMutableArray* constraintsToSearch = [NSMutableArray array];
    [constraintsToSearch addObjectsFromArray:self.superview.constraints];
    [constraintsToSearch addObjectsFromArray:self.constraints];
    return [[constraintsToSearch filteredArrayUsingPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:predicates]] firstObject];
}


- (NSLayoutConstraint *)addConstraintForAttribute:(NSLayoutAttribute)attribute withItem:(id)item withConstant:(CGFloat)constant withPriority:(UILayoutPriority)priority {
    NSLayoutAttribute toAttribute = item ? attribute : NSLayoutAttributeNotAnAttribute;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:item attribute:toAttribute multiplier:1 constant:constant];
    
    constraint.priority = priority;
    [((UIView *)item ?: self) addAndIdentifyConstraints:@[constraint]];
    return constraint;
}


#pragma mark - General Constraints
- (void)addAndIdentifyConstraints:(NSArray *)constraints {
    [constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *obj, NSUInteger idx, BOOL *stop) {
        [self identifyConstraint:obj];
    }];
    [self addConstraints:constraints];
}


#pragma mark - Private
- (NSLayoutConstraint *)identifyConstraint:(NSLayoutConstraint *)constraint {
    SEL identifierSelector = @selector(identifier);
    if ([constraint respondsToSelector:identifierSelector]) {
        [constraint setValue:Constraint_Identifier forKey:NSStringFromSelector(identifierSelector)];
    }
    return constraint;
}

@end
