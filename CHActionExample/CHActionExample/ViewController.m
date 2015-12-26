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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [CHAction chAction].doAction(^id(CHAction *action, CHCompletion completion) {
        completion(@"start");
        return nil;
    }).doAction(^id(CHAction *action, CHCompletion completion) {
        NSLog(@"step1:receive:%@",action.param);
        sleep(5);
        completion(@"step1");
        return nil;
    }).doAction(^id(CHAction *action, CHCompletion completion) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(2);
            NSLog(@"step2:receive:%@",action.param);
            completion(@"step2");
        });
        
        return nil;
    }).doAction(^id(CHAction *action, CHCompletion completion) {
        NSLog(@"step3:receive:%@",action.param);
        completion(@"step3");
        return nil;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
