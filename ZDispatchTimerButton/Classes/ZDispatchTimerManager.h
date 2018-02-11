//
//  ZDispatchTimerManager.h
//  ZDispatchTimerButton
//
//  Created by user on 2018/2/11.
//  Copyright © 2018年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDispatchTimerManager : NSObject

+ (instancetype)shareDispatchTimerManager;


/**
 开启gcd定时器
 
 @param timerName 定时器名称
 @param interval 执行间隔
 @param countDown 倒计时总时长
 @param queue 定时器运行的队列，默认全局队列
 @param repeat 定时器是否重复执行
 @param action 成功开启定时器执行的actionBlock
 @param cancel 关闭定时器时执行的cancelBlock
 */
- (void)scheduledDispatchTimerWithName:(NSString *)timerName timerInterval:(uint64_t)interval countDown:(NSInteger)countDown queue:(dispatch_queue_t)queue repeat:(BOOL)repeat action:(void (^)(NSInteger second))action cancel:(dispatch_block_t)cancel;


/**
 根据定时器名称关闭定时器
 
 @param timerName 定时器名称
 */
- (void)cancelTimerWithName:(NSString *)timerName;


/**
 清除所有的定时器
 */
- (void)cancelAllTimer;

@end
