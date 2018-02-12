//
//  AViewController.m
//  test
//
//  Created by 王家强 on 2018/2/3.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AViewController.h"

@interface AViewController ()


@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *buttonA = [self creatBtn];
    [self.view addSubview:buttonA];
    buttonA.frame = CGRectMake(0, 0, 200, 50);
    buttonA.center = self.view.center;
    buttonA.layer.borderWidth = 3;
    buttonA.layer.cornerRadius = 5;
    buttonA.layer.masksToBounds = YES;
    
    // BackgroundColor
    [buttonA setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
    [buttonA setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5] forState:UIControlStateSelected];
    // BorderColor
    [buttonA setBorderColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
    [buttonA setBorderColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [buttonA addTarget:self action:@selector(buttonATap:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonATap:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (UIButton *)creatBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"测试按钮" forState:UIControlStateNormal];
    
    return button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
