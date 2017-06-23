//
//  ViewController.m
//  RunLoop
//
//  Created by ycgwl on 2017/6/20.
//  Copyright © 2017年 lwj. All rights reserved.
//

#import "ViewController.h"
typedef BOOL(^RunloopBlock)(void);
@interface ViewController ()

/**
 存放任务的数组
 */
@property (nonatomic, retain)NSMutableArray *tasks;

/**
 最大任务数
 */
@property (nonatomic, assign)NSUInteger max;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _max = 18;
    _tasks = [NSMutableArray array];
    [self addRunloopObserver];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMothod) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, <#dispatchQueue#>);
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, <#intervalInSeconds#> * NSEC_PER_SEC, <#leewayInSeconds#> * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//        <#code to be executed when timer fires#>
//    });
//    dispatch_resume(timer);
}
- (void)timerMothod
{
    NSLog(@"timer-----");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
- (void)addRunloopObserver
{
//    typedef struct {
//        CFIndex    version;
//        void *    info;
//        const void *(*retain)(const void *info);
//        void    (*release)(const void *info);
//        CFStringRef    (*copyDescription)(const void *info);
//    } CFRunLoopObserverContext;
    // 上下文结构体
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    // 1.拿到当前的runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    static CFRunLoopObserverRef defaultModeObserver;
    // 创建观察者
    defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopAfterWaiting, YES, 0, &callBack, &context);
    // 添加当前观察者
    CFRunLoopAddObserver(runloop, defaultModeObserver, kCFRunLoopDefaultMode);
    // c语言与create就要有release
    CFRelease(defaultModeObserver);
}
static void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    ViewController *vc = (__bridge ViewController *)(info);
    if (vc.tasks.count==0) return;
    while (vc.tasks.count) {
        RunloopBlock unit = vc.tasks.firstObject;
        [vc.tasks removeObjectAtIndex:0];
    }
}
@end
