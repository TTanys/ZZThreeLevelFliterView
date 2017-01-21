//
//  ViewController.m
//  ZZThreeLevelFliterView
//
//  Created by zhajianjun on 2017/1/20.
//  Copyright © 2017年 TTanys. All rights reserved.
//

#import "ViewController.h"
#import "UIView+frame.h"
#import "ZZFilterMenuView.h"

@interface ViewController ()<ZZFilterMenuViewDelegate,ZZFilterMenuViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    ZZFilterMenuView *filterMenuView = [[ZZFilterMenuView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 44)];
    filterMenuView.delegate = self;
    filterMenuView.dataSource = self;
    [self.view addSubview:filterMenuView];
    
}

#pragma mark - ZZFilterMenuViewDataSource
- (NSInteger)filterMenuView:(ZZFilterMenuView *)filterMenuView numberOfRowsWithIndexPath:(ZZIndexPath *)indexPath{
    if (indexPath.column == 0 && indexPath.row == ZZNotFound) {
        return 10;
    }
    if (indexPath.column == 0 && indexPath.row != ZZNotFound && indexPath.item == ZZNotFound) {
        return 6;
    }
    if (indexPath.column == 0 && indexPath.row != ZZNotFound && indexPath.item != ZZNotFound && indexPath.rank == ZZNotFound) {
        return 8;
    }
    if (indexPath.column == 1 && indexPath.row == ZZNotFound) {
        return 7;
    }
    if (indexPath.column == 1 && indexPath.row != ZZNotFound && indexPath.item == ZZNotFound) {
        return 9;
    }
    if (indexPath.column == 2) {
        return 3;
    }
    return 0;
}

- (NSString *)filterMenuView:(ZZFilterMenuView *)filterMenuView titleOfRowWithIndexPath:(ZZIndexPath *)indexPath{
    // 左边 第一级
    if (indexPath.column == 0 && indexPath.row != ZZNotFound && indexPath.item == ZZNotFound) {
        return [NSString stringWithFormat:@"左第一级%ld",indexPath.row];
    }
    if (indexPath.column == 0 && indexPath.row != ZZNotFound && indexPath.item != ZZNotFound && indexPath.rank == ZZNotFound) {
        return [NSString stringWithFormat:@"左第二级%ld",indexPath.item];
    }
    if (indexPath.column == 0 && indexPath.row != ZZNotFound && indexPath.item != ZZNotFound && indexPath.rank != ZZNotFound) {
        return [NSString stringWithFormat:@"左第三级%ld",indexPath.rank];
    }
    if (indexPath.column == 1 && indexPath.row != ZZNotFound && indexPath.item == ZZNotFound) {
        return [NSString stringWithFormat:@"中第一级%ld",indexPath.row];
    }
    if (indexPath.column == 1 && indexPath.row != ZZNotFound && indexPath.item != ZZNotFound) {
        return [NSString stringWithFormat:@"中第二级%ld",indexPath.item];
    }
    if (indexPath.column == 2 && indexPath.row != ZZNotFound) {
        return [NSString stringWithFormat:@"右%ld",indexPath.row];
    }
    return @"";
}

#pragma mark - ZZFilterMenuViewDelegate
- (void)filterMenuView:(ZZFilterMenuView *)filterMenuView didSelectWithIndexPath:(ZZIndexPath *)indexPath{
    NSLog(@"--(%ld)--(%ld)--(%ld)--(%ld)--",indexPath.column,indexPath.row,indexPath.item,indexPath.rank);
    if (indexPath.column == 0 && indexPath.row != ZZNotFound && indexPath.item != ZZNotFound && indexPath.rank != ZZNotFound) {
        _infoLabel.text = [NSString stringWithFormat:@"左第三级%ld",indexPath.rank];
    }
    if (indexPath.column == 1 && indexPath.row != ZZNotFound && indexPath.item != ZZNotFound) {
        _infoLabel.text = [NSString stringWithFormat:@"中第二级%ld",indexPath.item];
    }
    if (indexPath.column == 2 && indexPath.row != ZZNotFound) {
        _infoLabel.text = [NSString stringWithFormat:@"右%ld",indexPath.row];
    }
}

@end
