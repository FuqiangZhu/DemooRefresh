//
//  ViewController.m
//  ElasticRefresh
//
//  Created by qiang on 16/7/13.
//  Copyright © 2016年 Qiang. All rights reserved.
//

#import "ViewController.h"
#import "PMElasticRefresh.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"PMElasticRefresh";    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView pm_RefreshHeaderWithBlock:^{
        
        NSLog(@"refreshBlock");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"加载数据完成");
            [self.mainTableView endRefresh];

        });
        
    }];
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
        
        NSMutableArray *arraM = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            NSString *string = [NSString stringWithFormat:@"这是数据%zd", i];
            [arraM addObject:string];
        }
        _dataArray = [arraM copy];
    }
    return _dataArray;
}


@end
