//
//  ViewController.m
//  CHActionExample
//
//  Created by ChangRong on 15/12/21.
//  Copyright © 2015年 CH. All rights reserved.
//

#import "ViewController.h"
#import "CHAction.h"


@interface ViewController ()

@property (nonatomic) NSString *str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [CHAction action:^(id result) {
        NSLog(@"%@",result);
    }].doAction(^id(CHAction *action){
        NSString *str = action.result;
        NSLog(@"block:%@",str);
        NSLog(@"result:%@",action.result);
        sleep(3);
        NSLog(@"thread:%@:%@",str,[NSThread currentThread]);
        return @"a";
    }).doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSString *str = action.result;
        NSLog(@"block:%@",str);
        NSLog(@"result:%@",action.result);
        sleep(3);
        NSLog(@"thread:%@:%@",str,[NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(2);
            NSLog(@"callback:thread:%@:%@",str,[NSThread currentThread]);
            finishBlock(@"b");
            
        });
    }).doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSString *str = action.result;
        NSLog(@"block:%@",str);
        NSLog(@"result:%@",action.result);
        sleep(3);
        NSLog(@"thread:%@:%@",str,[NSThread currentThread]);
        finishBlock(@"c");
        if (finishBlock) {
            NSLog(@"");
        }
    }).doAction(^id(CHAction *action){
        NSString *str = action.result;
        NSLog(@"block:%@",str);
        NSLog(@"result:%@",action.result);
        sleep(3);
        NSLog(@"thread:%@:%@",str,[NSThread currentThread]);
        return @"d";
    }).doAction(^id(CHAction *action){
        NSString *str = action.result;
        NSLog(@"block:%@",str);
        NSLog(@"result:%@",action.result);
        sleep(3);
        NSLog(@"thread:%@:%@",str,[NSThread currentThread]);
        return @"e";
    }).doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSString *str = action.result;
        NSLog(@"block:%@",str);
        NSLog(@"result:%@",action.result);
        sleep(3);
        NSLog(@"thread:%@:%@",str,[NSThread currentThread]);
        finishBlock(@"f");
    });
}

- (void)finishBlockDemo {
    [CHAction action:^(id result) {
        NSLog(@"%@",result);
    }].doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSLog(@"1%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@",action);
            sleep(3);
            self.str = @"aa";
            NSLog(@"2%@",[NSThread currentThread]);
            finishBlock(@"a");
        });
        NSLog(@"3%@",[NSThread currentThread]);
    }).doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSLog(@"1%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@",action);
            sleep(2);
            self.str = @"bb";
            NSLog(@"2%@",[NSThread currentThread]);
            finishBlock(@"b");
        });
        NSLog(@"3%@",[NSThread currentThread]);
    }).doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSLog(@"1%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@",action);
            sleep(5);
            [action cancel];
            NSLog(@"2%@",[NSThread currentThread]);
            finishBlock(@"c");
        });
        NSLog(@"3%@",[NSThread currentThread]);
    }).doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSLog(@"1%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@",action);
            sleep(2);
            self.str = @"bb";
            NSLog(@"2%@",[NSThread currentThread]);
            finishBlock(@"b");
        });
        NSLog(@"3%@",[NSThread currentThread]);
    }).doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSLog(@"1%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@",action);
            sleep(2);
            self.str = @"bb";
            NSLog(@"2%@",[NSThread currentThread]);
            finishBlock(@"b");
        });
        NSLog(@"3%@",[NSThread currentThread]);
    }).doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSLog(@"1%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@",action);
            sleep(2);
            self.str = @"bb";
            NSLog(@"2%@",[NSThread currentThread]);
            finishBlock(@"b");
        });
        NSLog(@"3%@",[NSThread currentThread]);
    }).doActionWithBlock(^(CHAction *action, void (^finishBlock)(id param)){
        NSLog(@"1%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@",action);
            sleep(2);
            self.str = @"bb";
            NSLog(@"2%@",[NSThread currentThread]);
            finishBlock(@"b");
        });
        NSLog(@"3%@",[NSThread currentThread]);
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
