//
//  ZDispatchTimerButton.h
//  ZDispatchTimerButton
//
//  Created by user on 2018/2/11.
//  Copyright © 2018年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDispatchTimerButton : UIButton

/**
 定时器总时长
 */
@property (assign, nonatomic) NSInteger totalCountDown;

/**
 定时器运行的队列，默认全局队列
 */
@property (strong, nonatomic) dispatch_queue_t currentQueue;

/**
 定时器执行间隔
 */
@property (assign, nonatomic) uint64_t timerInterval;

/**
 定时器总时长
 */
@property (assign, nonatomic) BOOL repeat;

/**
 定时器名称
 */
@property (copy, nonatomic) NSString *dispatchTimerName;

/**
 定时器按钮的标题
 */
@property (copy, nonatomic) NSString *dispatchButtonTitle;

/**
 定时器是否自动开启
 */
@property (assign, nonatomic) BOOL shouldAutoStartCount;

/**
 在定时器开始倒计时之前，对button执行相应的配置，但其实可以不用加上这个配置的block，直接设置button属性就行，但有一些属性是要在点击按钮或者是开启定时器时才需要设置，因此就加上了这个block
 */
@property (copy, nonatomic) void (^configBlock)(UIButton *sender);

/**
 关闭定时器
 */
- (void)closeCountDown;

@end
