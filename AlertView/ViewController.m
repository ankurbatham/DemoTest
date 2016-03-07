//
//  ViewController.m
//  AlertView
//
//  Created by Ankur Batham on 10/12/15.
//  Copyright © 2015 Ankur Batham. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlertView.h"
#import "CustomAlertViewDisplay.h"

@interface ViewController (){
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(IBAction)onClick:(id)sender{
    
    __block CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"The Title of my message can be up to 2 lines long. asdasdasdasdasdasdasd" message:@"And the message that is a bunch of text that will turn scrollable once the text view runs \nout of space.\n\nAnd And the message that is a bunch of text that will turn scrollable once the text view runs \nout of space.\n\nAndAnd the message that is a bunch of text that will turn scrollable once the text view runs \nout of space.\n\nAndAnd the message that is a bunch of text that will turn scrollable once the text view runs \nout of space.\n\nAndAnd the message that is a bunch of text that will turn scrollable once the text view runs \nout of space.\n\nAnd " actionCompleted:^(BOOL action, NSInteger idx){
        NSLog(@"%ld",(long)idx);
        [alert dismissAlert];
    }];
    
    alert.alertConfig.useVerticalLayoutForTwoButtons = @2;
    [alert.alertConfig.buttonArray addObject:@{@"index":@1,@"title":@"Edit Ad"}];
    [alert.alertConfig.buttonArray addObject:@{@"index":@2,@"title":@"Will later"}];
    alert.alertConfig.presentView=self.view;
    alert.alertConfig.isActiveAlert = YES;
    [alert show];    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
