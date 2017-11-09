//
//  ViewController.m
//  UITableView高级协议
//
//  Created by zh dk on 2017/8/28.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //自动调整子视图的大小
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    //设置代理
    _tableView.delegate = self;
    _tableView.dataSource  = self;
    
    //数据视图的头部和尾部视图设定
    _tableView.tableHeaderView = nil;
    _tableView.tableFooterView = nil;
    
    [self.view addSubview:_tableView];
    
    _arrayData = [[NSMutableArray alloc]init];
    for (int i=0; i<20; i++) {
        NSString *str= [NSString stringWithFormat:@"A %d",i];
        
        [_arrayData addObject:str];
    }
    
    //当数据视图的数据源发生变化时更新视图数据,重新加载数据
    [_tableView reloadData];
    
    [self createBtn];
    
}
//单元格显示效果协议
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //组合状态：多选
    return  UITableViewCellEditingStyleDelete;
}

//可以显示编辑状态，当手指在单元格上滑动时
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //删除数据源对应的数据
    [_arrayData removeObjectAtIndex:indexPath.row];
    
    //数据更新
    [_tableView reloadData];
}

//选中单元格调用此函数
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中单元格 %ld,%ld",indexPath.section,indexPath.row);
}


//取消选中单元格时调用此函数
-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"取消选中 %ld,%ld",indexPath.section,indexPath.row);
}

-(void) createBtn
{
    _isEdit = NO;
    
    _btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(pressEdit)];
    _btnDelete = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(pressDelete)];
    _btnFinish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(pressFinish)];
    
    self.navigationItem.rightBarButtonItem = _btnEdit;
    
}



-(void) pressEdit{
    _isEdit = YES;
    self.navigationItem.rightBarButtonItem = _btnFinish;
    [_tableView setEditing:YES];
    self.navigationItem.leftBarButtonItem = _btnDelete;
}

-(void) pressFinish
{
    _isEdit = NO;
    self.navigationItem.rightBarButtonItem = _btnEdit;
    [_tableView setEditing:NO];
    self.navigationItem.leftBarButtonItem = nil;
}
-(void) pressDelete{
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str= @"ID";
    //获取可复用的单元格
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    //单元格赋值
    cell.textLabel.text = [_arrayData objectAtIndex:indexPath.row];
    //设置子标题
    cell.detailTextLabel.text = @"子标题";
    //设置默认图标信息wscc
    NSString *strImg = [NSString stringWithFormat:@"%ld.jpg",indexPath.row % 11+1];
    
    UIImage *image = [UIImage imageNamed:strImg];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    cell.imageView.image = image;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
