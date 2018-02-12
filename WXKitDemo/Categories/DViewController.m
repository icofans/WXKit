//
//  DViewController.m
//  test
//
//  Created by 王家强 on 2018/2/3.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "DViewController.h"

@interface DViewController ()

@end

@implementation DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 20);
    label.text = @"如果有来生，要做一棵树，站成永恒，没有悲欢的姿势。一半在土里安详，一半在风里飞扬，一半洒落阴凉，一半沐浴阳光，非常沉默非常骄傲，从不依靠 从不寻找。";
    label.numberOfLines = 0;
    [self.view addSubview:label];
    [label sizeToFit];
    
    label.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    label.contentInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    
    
    NSArray *arr = [label lineText:@"如果有来生，要做一棵树，站成永恒，没有悲欢的姿势。一半在土里安详，一半在风里飞扬，一半洒落阴凉，一半沐浴阳光，非常沉默非常骄傲，从不依靠 从不寻找。" maxWidth:0 font:nil];
    
    
    NSLog(@"[%ld]-[%@]",arr.count,arr);
    
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
