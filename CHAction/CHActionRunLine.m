//
//  CHActionRunLine.m
//  CHActionExample
//
//  Created by ChangRong on 16/1/18.
//  Copyright © 2016年 CH. All rights reserved.
//

#import "CHActionRunLine.h"

@interface CHActionRunLine ()

@property (nonatomic) dispatch_queue_t internalQueue;

@end

@implementation CHActionRunLine

- (instancetype)initWithMainQueue {
    return [self initWithQueue:dispatch_get_main_queue()];
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue {
    self = [super init];
    if (self) {
        self.internalQueue = queue;
    }
    return self;
}

- (void)runWithBlock:(void (^)())block {
    dispatch_async(self.internalQueue, ^{
        if (block) {
            block();
        }
    });
}

@end
