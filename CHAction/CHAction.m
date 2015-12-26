//
//  CHAction.m
//  CHActionExample
//
//  Created by ChangRong on 15/12/21.
//  Copyright © 2015年 CH. All rights reserved.
//

#import "CHAction.h"

@interface CHAction ()


@end

@implementation CHAction

+ (instancetype)chAction {
    CHAction *chAction = [[CHAction alloc] init];
    return chAction;
}


- (CHAction *(^)(CHActionBlock block))doAction {
    return ^(CHActionBlock block){
        CHAction *chAction = [[CHAction alloc] init];
        
        block(self, ^(id param) {
            self.param = param;
        });
        return self;
    };
}
@end
