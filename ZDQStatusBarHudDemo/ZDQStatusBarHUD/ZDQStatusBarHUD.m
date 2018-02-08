//
//  ZDQStatusBarHUD.m
//  ZDQStatusBarHUD
//
//  Created by Albert on 2018/2/8.
//  Copyright © 2018年 Albert. All rights reserved.
//

#import "ZDQStatusBarHUD.h"

@implementation ZDQStatusBarHUD

static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;
/** 导航栏高度 */
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
/** HUD控件的高度 */
static CGFloat const ZDQWindowH = 20;
/** HUD控件的动画持续时间（出现\隐藏） */
static CGFloat const ZDQAnimationDuration = 0.25;
/** HUD控件默认会停留多长时间 */
static CGFloat const ZDQHUDStayDuration = 1.5;

+ (void)showImage:(UIImage *)image text:(NSString *)text
{
    // 停止之前的定时器
    [timer_ invalidate];
    
    // 创建窗口
    window_.hidden = YES; // 先隐藏之前的window
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    window_.frame = CGRectMake(0, - StatusBarHeight, [UIScreen mainScreen].bounds.size.width, StatusBarHeight);
    window_.hidden = NO;
    
    // 添加按钮
    CGFloat y = StatusBarHeight > 20 ? window_.frame.size.height-ZDQWindowH + 5: window_.frame.size.height-ZDQWindowH;
    CGFloat h = StatusBarHeight > 20 ? ZDQWindowH - 5: ZDQWindowH;
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, h);
    // 文字
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    // 图片
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    [window_ addSubview:button];
    
    // 动画
    [UIView animateWithDuration:ZDQAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = 0;
        window_.frame = frame;
    }];
    
    // 开启一个新的定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:ZDQHUDStayDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

+ (void)showImageName:(NSString *)imageName text:(NSString *)text
{
    [self showImage:[UIImage imageNamed:imageName] text:text];
}

+ (void)showSuccess:(NSString *)text
{
    [self showImageName:@"ZDQStatusBarHUD.bundle/success" text:text];
}

+ (void)showError:(NSString *)text
{
    [self showImageName:@"ZDQStatusBarHUD.bundle/error" text:text];
}

+ (void)showText:(NSString *)text
{
    [self showImage:nil text:text];
}

+ (void)showLoading:(NSString *)text
{
    // 停止之前的定时器
    [timer_ invalidate];
    timer_ = nil;
    
    // 创建窗口
    window_.hidden = YES; // 先隐藏之前的window
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    window_.frame = CGRectMake(0, - StatusBarHeight, [UIScreen mainScreen].bounds.size.width, StatusBarHeight);
    window_.hidden = NO;
    
    // 添加按钮
    UIButton *button = [[UIButton alloc] init];
    CGFloat y = StatusBarHeight > 20 ? window_.frame.size.height-ZDQWindowH + 5: window_.frame.size.height-ZDQWindowH;
    CGFloat h = StatusBarHeight > 20 ? ZDQWindowH - 5: ZDQWindowH;
    button.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, h);
    // 文字
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [window_ addSubview:button];
    
    // 圈圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    loadingView.frame = CGRectMake(button.titleLabel.frame.origin.x-60, y, h, h);
    [window_ addSubview:loadingView];
    
    // 动画
    [UIView animateWithDuration:ZDQAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = 0;
        window_.frame = frame;
    }];
}

+ (void)hide
{
    // 清空定时器
    [timer_ invalidate];
    timer_ = nil;
    
    // 退出动画
    [UIView animateWithDuration:ZDQAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y =  - StatusBarHeight;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
    }];
}
@end
