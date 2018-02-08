//
//  ViewController.m
//  ZDQStatusBarHudDemo
//
//  Created by Albert on 2018/2/8.
//  Copyright © 2018年 Albert. All rights reserved.
//

#import "ViewController.h"
#import "ZDQStatusBarHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hide:(id)sender {
    [ZDQStatusBarHUD hide];
}
- (IBAction)tipMessage:(id)sender {
    [ZDQStatusBarHUD showText:@"随便显示的文字！！！！"];
}
- (IBAction)loading:(id)sender {
    [ZDQStatusBarHUD showLoading:@"进行中的啦..."];
}
- (IBAction)fail:(id)sender {
    [ZDQStatusBarHUD showError:@"失败啦！"];
}

- (IBAction)success:(id)sender {
    [ZDQStatusBarHUD showSuccess:@"成功哦！"];
}

@end
