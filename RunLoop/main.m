//
//  main.m
//  RunLoop
//
//  Created by ycgwl on 2017/6/20.
//  Copyright © 2017年 lwj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        // UIApplicationMain 内部开启了死循环 保证主线程不退出 
        int a = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
        NSLog(@"来了");
        return a;
        
    }
}
