//
//  CHAction.m
//  CHActionExample
//
//  Created by ChangRong on 15/12/21.
//  Copyright © 2015年 CH. All rights reserved.
//

#import "CHAction.h"
#import "CHActionRunLine.h"

const char *kCHActionRunQueue = "kCHActionRunQueue";

@interface CHAction ()

@property (nonatomic, copy) CHActionWheel wheel;

@property (nonatomic, copy) CHActionBlockWithCompletion block;

@property (nonatomic) CHAction *nextAction;

@property (nonatomic) CHActionRunLine *runLine;

@property (nonatomic) dispatch_queue_t actionQueue;

@end

@implementation CHAction

- (instancetype)init {
    self = [super init];
    if (self) {
        self.runLine = [[CHActionRunLine alloc] initWithMainQueue];
    }
    return self;
}

+ (instancetype)action {
    CHAction *action = [[CHAction alloc] init];
    return action;
}

+ (instancetype)action:(CHActionWheel)block {
    CHAction *action = [[CHAction alloc] init];
    action.wheel = block;
    return action;
}

- (CHAction *(^)(CHActionBlockWithCompletion block))doActionWithBlock {
    CHAction *(^returnBlock)(CHActionBlockWithCompletion block) = ^CHAction *(CHActionBlockWithCompletion block) {
        return [self appendActionWithBlock:block];
    };
    return returnBlock;
}

- (CHAction *(^)(CHActionBlock block))doAction {
    CHAction *(^returnBlock)(CHActionBlock block) = ^CHAction *(CHActionBlock block) {
        return [self appendActionWithBlock:[self wrapComplectionBlock:block]];
    };
    return returnBlock;
}

#pragma mark - private API

- (dispatch_queue_t)actionQueue {
    if (!_actionQueue) {
        _actionQueue = dispatch_queue_create(kCHActionRunQueue, DISPATCH_QUEUE_SERIAL);
    }
    return _actionQueue;
}

- (CHAction *)appendActionWithBlock:(CHActionBlockWithCompletion)block {
    if (!self.nextAction && self.block) {
        [self createNextAction];
        self.nextAction.block = block;
        return self.nextAction;
    } else {
        self.block = block;
        [self doComplectionWheel:block];
        return self;
    }
}

- (CHActionBlockWithCompletion)wrapComplectionBlock:(CHActionBlock)block {
    return ^void(CHAction *action, CHCompletion completion) {
        completion(block(action));
    };
}

- (void)createNextAction {
    self.nextAction = [[CHAction alloc] init];
}

- (void)doComplectionWheel:(CHActionBlockWithCompletion)block {
    [self.runLine runWithBlock:^{
        block(self, ^(id param) {
            if (self.stop) {
                self.wheel(param);
                return;
            }
            self.block = nil;
            if (!self.nextAction) {
                return ;
            }
            self.nextAction.result = param;
            self.nextAction.wheel = self.wheel;
            self.wheel = nil;
            if (self.nextAction.block) {
                self.nextAction.runLine = self.runLine;
                [self.nextAction doComplectionWheel:self.nextAction.block];
            }
        });
    }];
    
}

@end
