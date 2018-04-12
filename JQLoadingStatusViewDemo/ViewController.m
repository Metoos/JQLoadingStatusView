//
//  ViewController.m
//  JQLoadingStatusViewDemo
//
//  Created by life on 2018/4/12.
//  Copyright © 2018年 zjq. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubViewController *sub = [[SubViewController alloc]init];
    switch (indexPath.row) {
        case 0:
        {
            sub.isShowEmpty = YES;
            break;
        }
        case 1:
        {
            sub.isShowEmpty = NO;
            break;
        }
        default:
            break;
    }
    
    [self.navigationController pushViewController:sub animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
