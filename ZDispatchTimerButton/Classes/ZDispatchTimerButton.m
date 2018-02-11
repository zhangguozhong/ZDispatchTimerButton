//
//  ZDispatchTimerButton.m
//  ZDispatchTimerButton
//
//  Created by user on 2018/2/11.
//  Copyright © 2018年 user. All rights reserved.
//

#import "ZDispatchTimerButton.h"
#import "ZDispatchTimerManager.h"

static NSInteger const DYLDispatchTimerButtonInterval = 1;
static NSInteger const DYLDispatchTimerButtonTotalCountDown = 60;

@implementation ZDispatchTimerButton

#pragma mark -- lifeCircle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self configButton];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configButton];
    }
    return self;
}

- (void)didMoveToWindow {
    if (self.window && self.shouldAutoStartCount) {
        [self startCountDown];
    }
}


/**
 配置按钮相关属性以及点击事件
 */
#pragma mark -- Private Method
- (void)configButton {
    self.timerInterval = DYLDispatchTimerButtonInterval;
    self.totalCountDown = DYLDispatchTimerButtonTotalCountDown;
    self.repeat = YES;
    self.shouldAutoStartCount = NO;
    self.dispatchTimerName = [[NSUUID UUID] UUIDString];
    [self addTarget:self action:@selector(startCountDown)forControlEvents:UIControlEventTouchUpInside];
}

// 开始倒计时
- (void)startCountDown {
    if (self.configBlock) {
        self.configBlock(self);
    }
    
    [[ZDispatchTimerManager shareDispatchTimerManager] scheduledDispatchTimerWithName:self.dispatchTimerName timerInterval:self.timerInterval countDown:self.totalCountDown queue:self.currentQueue repeat:self.repeat action:^(NSInteger second) {
                NSString *title = [NSString stringWithFormat:@"%ld秒", (long)second];
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            } cancel:^{
                self.enabled = YES;
                [self setTitle:self.dispatchButtonTitle forState:UIControlStateNormal];
            }];
}

- (void)setDispatchButtonTitle:(NSString *)dispatchButtonTitle {
    _dispatchButtonTitle = dispatchButtonTitle;
    if (dispatchButtonTitle && dispatchButtonTitle.length > 0) {
        [self setTitle:dispatchButtonTitle forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)closeCountDown {
    [[ZDispatchTimerManager shareDispatchTimerManager] cancelTimerWithName:self.dispatchTimerName];
}

- (void)dealloc {
    [self closeCountDown];
}

@end
