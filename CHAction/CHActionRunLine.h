//
//  CHActionRunLine.h
//  CHActionExample
//
//  Created by ChangRong on 16/1/18.
//  Copyright © 2016年 CH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHActionRunLine : NSObject

- (instancetype)initWithQueue:(dispatch_queue_t)queue;

- (instancetype)initWithMainQueue;

- (void)runWithBlock:(void (^)())block;

@end
