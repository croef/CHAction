//
//  CHAction.m
//  CHActionExample
//
//  Created by ChangRong on 15/12/21.
//  Copyright © 2015年 CH. All rights reserved.
//

#import "CHAction.h"


@interface CHAction ()

@property (nonatomic, copy) CHActionWheel wheel;

@property (nonatomic) BOOL isRunning;

@property (nonatomic, copy) CHActionBlockWithCompletion block;

@property (nonatomic) CHAction *nextAction;

@property (nonatomic) dispatch_queue_t internalQueue;

@end

@implementation CHAction

+ (instancetype)action {
    CHAction *action = [[CHAction alloc] init];
    return action;
}

+ (instancetype)action:(CHActionWheel)block {
    CHAction *action = [[CHAction alloc] init];
    action.wheel = block;
    action.internalQueue = dispatch_get_main_queue();
    return action;
}

- (CHAction *(^)(CHActionBlockWithCompletion block))doActionWithBlock {
    CHAction *(^returnBlock)(CHActionBlockWithCompletion block) = ^CHAction *(CHActionBlockWithCompletion block) {
        if (self.isRunning) {
            [self createNextAction];
            self.nextAction.isRunning = YES;
            self.nextAction.block = block;
            return self.nextAction;
        } else {
            self.isRunning = YES;
            self.block = block;
            [self doComplectionWheel:block];
            return self;
        }
    };
    return returnBlock;
}

- (CHAction *(^)(CHActionBlock block))doAction {
    CHAction *(^returnBlock)(CHActionBlock block) = ^CHAction *(CHActionBlock block) {
        [self doWheel:block];
        return self;
    };
    return returnBlock;
}

#pragma mark - private API

- (void)doWheel:(CHActionBlock)block {
    if (self.stop) {
        self.wheel(self.result);
        return;
    }
    self.result = block(self);
}


- (void)createNextAction {
    self.nextAction = [[CHAction alloc] init];
}

- (void)doComplectionWheel:(CHActionBlockWithCompletion)block {
    dispatch_async(self.internalQueue, ^{
        block(self, ^(id param) {
            if (self.stop) {
                self.wheel(param);
                return;
            }
            self.isRunning = NO;
            self.block = nil;
            if (!self.nextAction) {
                return ;
            }
            self.nextAction.result = param;
            self.nextAction.wheel = self.wheel;
            self.wheel = nil;
            if (self.nextAction.block) {
                self.nextAction.internalQueue = self.internalQueue;
                [self.nextAction doComplectionWheel:self.nextAction.block];
            }
        });
    });
    
}

@end
