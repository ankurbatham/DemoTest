//
//  CustomAlertView.m
//  AlertView
//
//  Created by Ankur Batham on 10/12/15.
//  Copyright © 2015 Ankur Batham. All rights reserved.
//

#import "CustomAlertView.h"
#import "CustomAlertViewDisplay.h"

@interface CustomAlertView (){
    
}
@property(nonatomic, strong)CustomAlertViewDisplay *alertView;
@property (nonatomic, strong) NSLayoutConstraint *yPosConstraint;
@property (nonatomic, assign) BOOL alertVisible;
@property (nonatomic, strong) UIImageView *blurImageView;
@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation CustomAlertView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor clearColor];
    
    if([self.alertConfig.blurEnabled boolValue]){
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            self.view.backgroundColor = [UIColor clearColor];
            
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            blurEffectView.frame = self.view.bounds;
            blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
            [self.view addSubview:blurEffectView];
        }
        else {
            self.view.backgroundColor = [UIColor blackColor];
        }
    }else if (self.alertConfig.backgroundViewTintColor) {
            self.view.backgroundColor = self.alertConfig.backgroundViewTintColor;
        }
     [self.view addSubview:self.alertView];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Added this check so if you presented a modal via a passive alert then
    //   dismissed that modal, another alert is not added to the view if the alert
    //   did not finish dismissing yet
    
    [self setVisible:YES animated:YES completion:nil];
  
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message actionCompleted:(AlertViewButtonTouched)completionBlock {
    
    self = [super init];
    if (self) {
        self.alertConfig = [CustomAlertConfig new];
        self.alertConfig.title = title;
        self.alertConfig.message = message;
        self.alertConfig.buttonArray=[NSMutableArray array];
        self.alertConfig.completionBlock=completionBlock;
    }
    return self;
}




- (void)show {
    self.alertView = [[CustomAlertViewDisplay alloc] initWithAlertConfig:self.alertConfig];
    self.alertView.alpha = 0;
    self.alertView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat sideMargins = screenWidth * 0.05;
    NSDictionary *metrics = @{@"sideMargins" : @(sideMargins)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideMargins-[_alertView]-sideMargins-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_alertView)]];
    
    self.yPosConstraint = [NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:self.yPosConstraint];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    
    // add alert view in to window
    CGRect rect = self.view.frame;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT;
    self.view.frame = rect;
    [self setupAlertWindow];
    [self.alertWindow addSubview:self.view];
    [self.alertWindow bringSubviewToFront:self.view];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated completion:(void (^)(BOOL finished))complete {
    self.alertVisible = visible;
    
    CGFloat scaler = 0.3f;
    if (visible) {
        self.alertView.alpha = 0.0;
        self.alertView.transform = CGAffineTransformMakeScale(scaler, scaler);
    }
    
    CGFloat alpha = visible ? 1.0 : 0.0;
    CGAffineTransform transform = visible ? CGAffineTransformIdentity : CGAffineTransformMakeScale(scaler, scaler);
    
    void (^bounceAnimation)() = ^(void) {
        self.alertView.transform = transform;
    };
    
    void (^fadeAnimation)() = ^(void) {
        self.alertView.alpha = alpha;
        self.view.alpha = alpha;
    };
    
    if (animated) {
        CGFloat duration = 0.6;
        CGFloat damping = 0.6;
        CGFloat initialVelocity = visible ? 0 : -10;
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:initialVelocity options:0 animations:bounceAnimation completion:^(BOOL finished) {
            
            if(!self.alertVisible){
                [self.alertView removeFromSuperview];
                self.alertView =nil;
            }
            if(complete)
              complete(visible);

        }];
        
        [UIView animateWithDuration:(duration / 2.0) animations:fadeAnimation completion:nil];
    }
    else {
        fadeAnimation();
        bounceAnimation();
        if(!self.alertVisible){
            [self.alertView removeFromSuperview];
            self.alertView =nil;
        }
        if(complete)
            complete(visible);
    }
}

-(void)dismissAlert{
    [self dismissAlert:nil];
}


- (void)dismissAlert:(void (^)(BOOL finished))complete {
    
    __strong typeof(self) strongSelf = self;
    [self setVisible:NO animated:YES completion:^(BOOL finish){
        
        __weak typeof (self) weakSelf = strongSelf;
        if(!finish){

            NSArray *subViewArray = [weakSelf.alertWindow subviews];
            for (id obj in subViewArray)
            {
                [obj removeFromSuperview];
            }
            
            if(complete)
              complete(YES);
        }
    }];
    
}


- (void)setupAlertWindow {
    if (self.alertWindow) {
        return;
    }
    self.alertWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.alertWindow.windowLevel = UIWindowLevelAlert;
    self.alertWindow.hidden = NO;
    self.alertWindow.backgroundColor = [UIColor clearColor];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignActive:) name:UIWindowDidBecomeKeyNotification object:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
