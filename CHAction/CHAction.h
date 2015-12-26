//
//  CHAction.h
//  CHActionExample
//
//  Created by ChangRong on 15/12/21.
//  Copyright © 2015年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CHAction;

typedef void(^CHCompletion)(id param);

typedef id(^CHActionBlock)(CHAction *action, CHCompletion completion);


@interface CHAction : NSObject

@property (nonatomic) id param;


+ (instancetype)chAction;

- (CHAction *(^)(CHActionBlock block))doAction;


- (void)test:(CHActionBlock)block;
@end
