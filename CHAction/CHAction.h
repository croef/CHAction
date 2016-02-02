//
//  CHAction.h
//  CHActionExample
//
//  Created by ChangRong on 15/12/21.
//  Copyright © 2015年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCancel.h"

@class CHAction;

typedef void(^CHActionWheel)(id result);

typedef void(^CHCompletion)(id param);

typedef void(^CHActionBlockWithCompletion)(CHAction *action, CHCompletion completion);

typedef id(^CHActionBlock)(CHAction *action);


@interface CHAction : NSObject

@property (nonatomic) id result;

+ (instancetype)action;

+ (instancetype)action:(CHActionWheel)block;

- (CHAction *(^)(CHActionBlockWithCompletion block))doActionWithBlock;

- (CHAction *(^)(CHActionBlock block))doAction;

- (void)cancel;

@end
