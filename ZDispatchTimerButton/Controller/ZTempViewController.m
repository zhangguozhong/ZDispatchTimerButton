//
//  ZTempViewController.m
//  ZDispatchTimerButton
//
//  Created by user on 2018/2/11.
//  Copyright © 2018年 user. All rights reserved.
//

#import "ZTempViewController.h"
#import "ZDispatchTimerButton.h"

@interface ZTempViewController () {
    ZDispatchTimerButton *_timerButton;
}
@end

@implementation ZTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _timerButton = [[ZDispatchTimerButton alloc] initWithFrame:CGRectMake(0, 90, 200, 40)];
    _timerButton.dispatchButtonTitle = @"开始计时";
    _timerButton.configBlock = ^(UIButton *sender) {
        sender.enabled = NO;
    };
    [self.view addSubview:_timerButton];
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
