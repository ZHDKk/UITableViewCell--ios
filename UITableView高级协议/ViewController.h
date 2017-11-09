//
//  ViewController.h
//  UITableView高级协议
//
//  Created by zh dk on 2017/8/28.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tableView;
    
    //数据源
    NSMutableArray *_arrayData;
    
    //添加导航按钮
    UIBarButtonItem *_btnEdit;
    UIBarButtonItem *_btnFinish;
    UIBarButtonItem *_btnDelete;
    //设置编辑状态
    BOOL _isEdit;
}


@end

