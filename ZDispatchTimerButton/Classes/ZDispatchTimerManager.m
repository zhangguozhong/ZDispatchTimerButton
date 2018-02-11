//
//  ZDispatchTimerManager.m
//  ZDispatchTimerButton
//
//  Created by user on 2018/2/11.
//  Copyright © 2018年 user. All rights reserved.
//

#import "ZDispatchTimerManager.h"

@interface ZDispatchTimerManager ()

@property (strong, nonatomic) NSMutableDictionary *timerStorage;

@end

@implementation ZDispatchTimerManager

+ (instancetype)shareDispatchTimerManager {
    static dispatch_once_t onceTimerToken;
    static ZDispatchTimerManager *dispatchTimerManager;
    dispatch_once(&onceTimerToken, ^{
        dispatchTimerManager = [[ZDispatchTimerManager alloc] init];
    });
    return dispatchTimerManager;
}


- (void)scheduledDispatchTimerWithName:(NSString *)timerName timerInterval:(uint64_t)interval countDown:(NSInteger)countDown queue:(dispatch_queue_t)queue repeat:(BOOL)repeat action:(void (^)(NSInteger))action cancel:(dispatch_block_t)cancel {
    if (!timerName) {
        return;
    }
    
    if (!queue) {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    
    dispatch_source_t timerSource = self.timerStorage[timerName];
    if (!timerSource) {
        timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timerSource);
        self.timerStorage[timerName] = timerSource;
    }
    
    
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_timer(timerSource, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0);
    NSDate *startDate = [NSDate date];
    
    if (action) {
        dispatch_source_set_event_handler(timerSource, ^{
            NSTimeInterval deltaTime = [[NSDate date] timeIntervalSinceDate:startDate];
            NSInteger second = countDown - (NSInteger)(deltaTime + 0.5);
            if (second < 0) {
                [weakSelf cancelTimerWithName:timerName];
            } else {
                if ([NSThread currentThread].isMainThread) {
                    action(second);
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        action(second);
                    });
                }
            }
            
            if (!repeat) {
                [weakSelf cancelTimerWithName:timerName];
            }
        });
    }
    
    if (cancel) {
        dispatch_source_set_cancel_handler(timerSource, ^{
            if ([NSThread currentThread].isMainThread) {
                cancel();
            } else {
                dispatch_async(dispatch_get_main_queue(), cancel);
            }
        });
    }
}


- (void)cancelTimerWithName:(NSString *)timerName {
    dispatch_source_t timerSource = self.timerStorage[timerName];
    if (!timerSource) {
        return;
    }
    
    [self.timerStorage removeObjectForKey:timerName];
    dispatch_source_cancel(timerSource);
}


- (void)cancelAllTimer {
    [self.timerStorage enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull timerName, id  _Nonnull obj, BOOL * _Nonnull stop) {
         [self cancelTimerWithName:timerName];
     }];
}


- (NSMutableDictionary *)timerStorage {
    if (!_timerStorage) {
        _timerStorage = [[NSMutableDictionary alloc] init];
    }
    return _timerStorage;
}

@end
