//
//  CategroyController.m
//  test
//
//  Created by 王家强 on 2018/2/3.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CategroyController.h"

@interface CategroyController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *dataArr;

@end

@implementation CategroyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"WXKit-Categroy";
    
    [self.view addSubview:self.tableView];
    self.dataArr = @[@"UIButton+WXExtension",@"UIColor+WXExtension",@"UIImage+WXExtension",@"UILabel+WXExtension",@"UITableView+WXEmpty",@"UIViewController+WXMediator"];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *classArr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G"];
    UIViewController *vc = [UIViewController instantiateViewController:[NSString stringWithFormat:@"%@ViewController",classArr[indexPath.row]]];
    [vc setTitle:self.dataArr[indexPath.row]];
    [vc.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
    
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
