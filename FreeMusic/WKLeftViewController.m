//
//  DZLeftViewController.m
//  Music
//
//  Created by dengwei on 16/1/2.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "WKLeftViewController.h"

@interface WKLeftViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_options;
}

@end

@implementation WKLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _options = @[@"网络", @"本地", @"关于"];
    
    [self setupTableView];
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight, kViewWidth, kViewHeight) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0/255.0 green:136/255.0 blue:1 alpha:1];
    self.tableView.scrollEnabled = NO; //设置tableview 不能滚动
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idfentifier = @"leftViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:idfentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = _options[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) { //点击"首页”
        if ([_delegate respondsToSelector:@selector(showHomeView)]) {
            [_delegate showHomeView];
        }
    }else if(indexPath.row == 1){ //点击“在线音乐”
        if ([_delegate respondsToSelector:@selector(showOnlineMusicView)]) {
            [_delegate showOnlineMusicView];
        }
    }else if(indexPath.row == 2){ //点击“关于”
        if ([_delegate respondsToSelector:@selector(showAboutView)]) {
            [_delegate showAboutView];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
