//
//  ZZFilterMenuView.h
//  ZZThreeLevelFliterView
//
//  Created by zhajianjun on 2017/1/20.
//  Copyright © 2017年 TTanys. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZZNotFound (-1)

@class ZZFilterMenuView,ZZIndexPath;

@protocol ZZFilterMenuViewDelegate <NSObject>

- (void)filterMenuView:(ZZFilterMenuView *)filterMenuView didSelectWithIndexPath:(ZZIndexPath *)indexPath;

@end

@protocol ZZFilterMenuViewDataSource <NSObject>

- (NSInteger)filterMenuView:(ZZFilterMenuView *)filterMenuView numberOfRowsWithIndexPath:(ZZIndexPath *)indexPath;

- (NSString *)filterMenuView:(ZZFilterMenuView *)filterMenuView titleOfRowWithIndexPath:(ZZIndexPath *)indexPath;

@end

@interface ZZFilterMenuView : UIView

@property (nonatomic, strong) UITableView *leftTableView_0;
@property (nonatomic, strong) UITableView *leftTableView_1;
@property (nonatomic, strong) UITableView *leftTableView_2;
@property (nonatomic, strong) UITableView *middleTableView_0;
@property (nonatomic, strong) UITableView *middleTableView_1;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, weak) id<ZZFilterMenuViewDelegate> delegate;
@property (nonatomic, weak) id<ZZFilterMenuViewDataSource> dataSource;

@end

@interface ZZIndexPath : NSObject

@property (nonatomic, assign) NSInteger column; //区分：从左至右0,1,2
@property (nonatomic, assign) NSInteger row;    //左边第一级的行
@property (nonatomic, assign) NSInteger item;   //左边第二级的行
@property (nonatomic, assign) NSInteger rank;   //左边第三级的行

+ (instancetype)indexPathWithColumn:(NSInteger)column
                                row:(NSInteger)row
                               item:(NSInteger)item
                               rank:(NSInteger)rank;

@end
