//
//  BViewController.m
//  test
//
//  Created by 王家强 on 2018/2/3.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

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
    buttonA.layer.borderColor = [UIColor clearColor].CGColor;
    
    buttonA.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [buttonA addTarget:self action:@selector(buttonATap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonATap:(UIButton *)sender
{
    // [UIColor colorWithHexString:@"#ffaa00"]
    int num = abs(rand())%0xFFFFFF;
    NSString *colorStr = [NSString stringWithFormat:@"%06x", num];
    [sender setBackgroundColor:[UIColor colorWithHexString:colorStr]];
    [sender setTitle:colorStr forState:UIControlStateNormal];
}

- (UIButton *)creatBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"换颜色" forState:UIControlStateNormal];
    
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
