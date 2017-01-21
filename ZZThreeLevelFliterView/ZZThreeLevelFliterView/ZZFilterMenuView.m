//
//  ZZFilterMenuView.m
//  ZZThreeLevelFliterView
//
//  Created by zhajianjun on 2017/1/20.
//  Copyright © 2017年 TTanys. All rights reserved.
//

#import "ZZFilterMenuView.h"
#import "UIView+frame.h"

#define ZZScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ZZScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ZZTableViewMaxHeight 300
#define ZZTopBtnHeight 44

static NSString *ZZ_CELL_IDENT = @"ZZ_CELL_IDENT";

@interface ZZFilterMenuView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectColumn;
    NSInteger _selectRow;
    NSInteger _selectItem;
    NSInteger _selectRank;
    
    NSInteger _selectMidRow;
    NSInteger _selectMidItem;
    
    CGFloat _rightTableViewHeight;
    BOOL _isLeftOpen;
    BOOL _isMiddleOpen;
    BOOL _isRightOpen;
}
@property (nonatomic, strong) UIButton *bgButton; //背景
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation ZZFilterMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        [self setupButton];
        [self setupSubViews];
    }
    return self;
}

//初始化信息
- (void)initialize{
    _selectColumn = 0;
    _selectItem = ZZNotFound;
    _selectRank = ZZNotFound;
    _selectRow = ZZNotFound;
    _selectMidRow = ZZNotFound;
    _selectMidItem = ZZNotFound;
    _isLeftOpen = NO;
    _isMiddleOpen = NO;
    _isRightOpen = NO;
}

//设置Button
- (void)setupButton{
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(0, 0, ZZScreenWidth/3.0, ZZTopBtnHeight);
    self.leftButton.backgroundColor = [UIColor whiteColor];
    [self.leftButton setTitle:@"左边" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor colorWithWhite:0.004 alpha:1.000] forState:UIControlStateNormal];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.leftButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftButton];
    
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(self.leftButton.right-1, (ZZTopBtnHeight-20)/2.0, 1, 20)];
    line0.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line0];
    
    self.middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.middleButton.frame = CGRectMake(self.leftButton.right, 0, ZZScreenWidth/3.0, ZZTopBtnHeight);
    self.middleButton.backgroundColor = [UIColor whiteColor];
    [self.middleButton setTitle:@"中间" forState:UIControlStateNormal];
    [self.middleButton setTitleColor:[UIColor colorWithWhite:0.004 alpha:1.000] forState:UIControlStateNormal];
    self.middleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.middleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.middleButton];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(self.middleButton.right-1, (ZZTopBtnHeight-20)/2.0, 1, 20)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line1];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(self.middleButton.right, 0, ZZScreenWidth/3.0, ZZTopBtnHeight);
    self.rightButton.backgroundColor = [UIColor whiteColor];
    [self.rightButton  setTitle:@"右边" forState:UIControlStateNormal];
    [self.rightButton  addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitleColor:[UIColor colorWithWhite:0.004 alpha:1.000]  forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.rightButton];
    
    UIView *bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, ZZTopBtnHeight-0.5, ZZScreenWidth, 0.5)];
    bottomShadow.backgroundColor = [UIColor colorWithRed:0.468 green:0.485 blue:0.465 alpha:1.000];
    [self addSubview:bottomShadow];
}

- (void)setupSubViews{
    [self addSubview:self.bgButton];
    [self.bgButton addSubview:self.leftTableView_0];
    [self.bgButton addSubview:self.leftTableView_1];
    [self.bgButton addSubview:self.leftTableView_2];
    [self.bgButton addSubview:self.middleTableView_0];
    [self.bgButton addSubview:self.middleTableView_1];
    [self.bgButton addSubview:self.rightTableView];
}

- (UIButton *)bgButton{
    if (!_bgButton) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor clearColor];
        _bgButton.frame = CGRectMake(0, ZZTopBtnHeight, self.width, self.height-ZZTopBtnHeight);
        [_bgButton addTarget:self action:@selector(bgAction:) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.clipsToBounds = YES;
    }
    return _bgButton;
}

- (UITableView *)leftTableView_0{
    if (!_leftTableView_0) {
        _leftTableView_0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width/3.0, self.height) style:UITableViewStylePlain];
        [_leftTableView_0 registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZ_CELL_IDENT];
        _leftTableView_0.delegate = self;
        _leftTableView_0.dataSource = self;
        _leftTableView_0.tableFooterView = [[UIView alloc] init];
    }
    return _leftTableView_0;
}

- (UITableView *)leftTableView_1{
    if (!_leftTableView_1) {
        _leftTableView_1 = [[UITableView alloc] initWithFrame:CGRectMake(self.width/3.0, 0, self.width/3.0, self.height) style:UITableViewStylePlain];
        _leftTableView_1.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_leftTableView_1 registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZ_CELL_IDENT];
        _leftTableView_1.delegate = self;
        _leftTableView_1.dataSource = self;
        _leftTableView_1.tableFooterView = [[UIView alloc] init];
    }
    return _leftTableView_1;
}

- (UITableView *)leftTableView_2{
    if (!_leftTableView_2) {
        _leftTableView_2 = [[UITableView alloc] initWithFrame:CGRectMake((self.width/3.0)*2, 0, self.width/3.0, self.height) style:UITableViewStylePlain];
        _leftTableView_2.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
        [_leftTableView_2 registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZ_CELL_IDENT];
        _leftTableView_2.delegate = self;
        _leftTableView_2.dataSource = self;
        _leftTableView_2.tableFooterView = [[UIView alloc] init];
    }
    return _leftTableView_2;
}

- (UITableView *)middleTableView_0{
    if (!_middleTableView_0) {
        _middleTableView_0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width/2.0, self.height) style:UITableViewStylePlain];
        [_middleTableView_0 registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZ_CELL_IDENT];
        _middleTableView_0.delegate = self;
        _middleTableView_0.dataSource = self;
        _middleTableView_0.tableFooterView = [[UIView alloc] init];
    }
    return _middleTableView_0;
}

- (UITableView *)middleTableView_1{
    if (!_middleTableView_1) {
        _middleTableView_1 = [[UITableView alloc] initWithFrame:CGRectMake(self.width/2.0, 0, self.width/2.0, self.height) style:UITableViewStylePlain];
        _middleTableView_1.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_middleTableView_1 registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZ_CELL_IDENT];
        _middleTableView_1.delegate = self;
        _middleTableView_1.dataSource = self;
        _middleTableView_1.tableFooterView = [[UIView alloc] init];
    }
    return _middleTableView_1;
}

- (UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        [_rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZ_CELL_IDENT];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.tableFooterView = [[UIView alloc] init];
    }
    return _rightTableView;
}

#pragma mark - change TableViews
- (void)showLeftTableViews{
    self.leftTableView_0.frame = CGRectMake(self.leftTableView_0.frame.origin.x, self.leftTableView_0.frame.origin.y, self.leftTableView_0.frame.size.width, ZZTableViewMaxHeight);
    self.leftTableView_1.frame = CGRectMake(self.leftTableView_1.frame.origin.x, self.leftTableView_1.frame.origin.y, self.leftTableView_1.frame.size.width, ZZTableViewMaxHeight);
    self.leftTableView_2.frame = CGRectMake(self.leftTableView_2.frame.origin.x, self.leftTableView_2.frame.origin.y, self.leftTableView_2.frame.size.width, ZZTableViewMaxHeight);
}

- (void)hiddenLeftTableViews{
    self.leftTableView_0.frame = CGRectMake(self.leftTableView_0.frame.origin.x, self.leftTableView_0.frame.origin.y, self.leftTableView_0.frame.size.width, 0);
    self.leftTableView_1.frame = CGRectMake(self.leftTableView_1.frame.origin.x, self.leftTableView_1.frame.origin.y, self.leftTableView_1.frame.size.width, 0);
    self.leftTableView_2.frame = CGRectMake(self.leftTableView_2.frame.origin.x, self.leftTableView_2.frame.origin.y, self.leftTableView_2.frame.size.width, 0);
}

- (void)showMiddleTableView{
    self.middleTableView_0.frame = CGRectMake(self.middleTableView_0.frame.origin.x, self.middleTableView_0.frame.origin.y, self.middleTableView_0.frame.size.width, ZZTableViewMaxHeight);
    self.middleTableView_1.frame = CGRectMake(self.middleTableView_1.x, self.middleTableView_1.y, self.middleTableView_1.width, ZZTableViewMaxHeight);
}

- (void)hiddenMiddleTableView{
    self.middleTableView_0.frame = CGRectMake(self.middleTableView_0.frame.origin.x, self.middleTableView_0.frame.origin.y, self.middleTableView_0.frame.size.width, 0);
    self.middleTableView_1.frame = CGRectMake(self.middleTableView_1.x, self.middleTableView_1.y, self.middleTableView_1.width, 0);
}

- (void)showRightTableView{
    CGFloat height = MIN(_rightTableViewHeight, ZZTableViewMaxHeight);
    self.rightTableView.frame = CGRectMake(self.rightTableView.frame.origin.x, self.rightTableView.frame.origin.y, self.rightTableView.frame.size.width, height);
}

- (void)hiddenRightTableView{
    self.rightTableView.frame = CGRectMake(self.rightTableView.frame.origin.x, self.rightTableView.frame.origin.y, self.rightTableView.frame.size.width, 0);
}

- (void)changeTopButtonTitle:(NSString *)string{
    if (_selectColumn == 0) {
        [self.leftButton setTitle:string forState:UIControlStateNormal];
    }
    if (_selectColumn == 1) {
        [self.middleButton setTitle:string forState:UIControlStateNormal];
    }
    if (_selectColumn == 2) {
        [self.rightButton setTitle:string forState:UIControlStateNormal];
    }
}

#pragma mark - buttons Action
- (void)buttonAction:(UIButton *)sender{
    if (self.leftButton == sender) {
        if (_isLeftOpen) {
            _isLeftOpen = !_isLeftOpen;
            [self bgAction:nil];
            return;
        }
        _selectColumn = 0;
        _isLeftOpen = YES;
        _isMiddleOpen = NO;
        _isRightOpen = NO;
        [self hiddenMiddleTableView];
        [self hiddenRightTableView];
    }
    if (self.middleButton == sender) {
        if (_isMiddleOpen) {
            _isMiddleOpen = !_isMiddleOpen;
            [self bgAction:nil];
            return;
        }
        _selectColumn = 1;
        _isLeftOpen = NO;
        _isMiddleOpen = YES;
        _isRightOpen = NO;
        [self hiddenLeftTableViews];
        [self hiddenRightTableView];
    }
    if (self.rightButton == sender) {
        if (_isRightOpen) {
            _isRightOpen = !_isRightOpen;
            [self bgAction:nil];
            return;
        }
        _selectColumn = 2;
        _isLeftOpen = NO;
        _isMiddleOpen = NO;
        _isRightOpen = YES;
        [self hiddenLeftTableViews];
        [self hiddenMiddleTableView];
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, ZZScreenWidth, ZZScreenHeight);
    self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, self.bounds.size.height - ZZTopBtnHeight);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        if (_selectColumn == 0) {
            [self showLeftTableViews];
        }
        if (_selectColumn == 1) {
            [self showMiddleTableView];
        }
        if (_selectColumn == 2) {
            [self showRightTableView];
        }
    } completion:^(BOOL finished) {
        //
    }];
}

- (void)bgAction:(UIButton *)sender{
    _isLeftOpen = NO;
    _isMiddleOpen = NO;
    _isRightOpen = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.bgButton.backgroundColor = [UIColor clearColor];
        [self hiddenLeftTableViews];
        [self hiddenMiddleTableView];
        [self hiddenRightTableView];
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, ZZScreenWidth, ZZTopBtnHeight);
        self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, 0);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZZIndexPath *zzIndexPath = [self getIndexPathForNumberOfRowsWithTableView:tableView];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(filterMenuView:numberOfRowsWithIndexPath:)]) {
        NSInteger count = [self.dataSource filterMenuView:self numberOfRowsWithIndexPath:zzIndexPath];
        if (zzIndexPath.column == 2) {
            _rightTableViewHeight = count * 44;
        }
        return count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZIndexPath *zzIndexPath = [self getIndexPathForCellWithTableView:tableView indexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZ_CELL_IDENT];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.004 alpha:1.000];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.separatorInset = UIEdgeInsetsZero;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(filterMenuView:titleOfRowWithIndexPath:)]) {
        cell.textLabel.text = [self.dataSource filterMenuView:self titleOfRowWithIndexPath:zzIndexPath];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self changeTopButtonTitle:cell.textLabel.text];
    
    if (tableView == self.leftTableView_0) {
        _selectRow = indexPath.row;
        _selectItem = ZZNotFound;
        _selectRank = ZZNotFound;
        [self.leftTableView_1 reloadData];
        [self.leftTableView_2 reloadData];
    }
    if (tableView == self.leftTableView_1) {
        _selectItem = indexPath.row;
        _selectRank = ZZNotFound;
        [self.leftTableView_2 reloadData];
    }
    if (tableView == self.leftTableView_2) {
        [self bgAction:nil];
    }
    if (tableView == self.middleTableView_0) {
        _selectMidRow = indexPath.row;
        _selectMidItem = ZZNotFound;
        [self.middleTableView_1 reloadData];
    }
    if (tableView == self.middleTableView_1) {
        [self bgAction:nil];
    }
    if (tableView == self.rightTableView) {
        [self bgAction:nil];
    }
    
    ZZIndexPath *zzIndexPath = [self getIndexPathForCellWithTableView:tableView indexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterMenuView:didSelectWithIndexPath:)]) {
        [self.delegate filterMenuView:self didSelectWithIndexPath:zzIndexPath];
    }
}

- (ZZIndexPath *)getIndexPathForNumberOfRowsWithTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView_0) {
        return [ZZIndexPath indexPathWithColumn:0 row:ZZNotFound item:ZZNotFound rank:ZZNotFound];
    }
    if (tableView == self.leftTableView_1 && _selectRow != ZZNotFound) {
        return [ZZIndexPath indexPathWithColumn:0 row:_selectRow item:ZZNotFound rank:ZZNotFound];
    }
    if (tableView == self.leftTableView_2 && _selectRow != ZZNotFound && _selectItem != ZZNotFound) {
        return [ZZIndexPath indexPathWithColumn:0 row:_selectRow item:_selectItem rank:ZZNotFound];
    }
    if (tableView == self.middleTableView_0) {
        return [ZZIndexPath indexPathWithColumn:1 row:ZZNotFound item:ZZNotFound rank:ZZNotFound];
    }
    if (tableView == self.middleTableView_1 && _selectMidRow != ZZNotFound) {
        return [ZZIndexPath indexPathWithColumn:1 row:_selectMidRow item:ZZNotFound rank:ZZNotFound];
    }
    if (tableView == self.rightTableView) {
        return [ZZIndexPath indexPathWithColumn:2 row:ZZNotFound item:ZZNotFound rank:ZZNotFound];
    }
    
    return 0;
}

- (ZZIndexPath *)getIndexPathForCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView_0) {
        return [ZZIndexPath indexPathWithColumn:0 row:indexPath.row item:ZZNotFound rank:ZZNotFound];
    }
    if (tableView == self.leftTableView_1) {
        return [ZZIndexPath indexPathWithColumn:0 row:_selectRow item:indexPath.row rank:ZZNotFound];
    }
    if (tableView == self.leftTableView_2) {
        return [ZZIndexPath indexPathWithColumn:0 row:_selectRow item:_selectItem rank:indexPath.row];
    }
    if (tableView == self.middleTableView_0) {
        return [ZZIndexPath indexPathWithColumn:1 row:indexPath.row item:ZZNotFound rank:ZZNotFound];
    }
    if (tableView == self.middleTableView_1) {
        return [ZZIndexPath indexPathWithColumn:1 row:_selectMidRow item:indexPath.row rank:ZZNotFound];
    }
    if (tableView == self.rightTableView) {
        return [ZZIndexPath indexPathWithColumn:2 row:indexPath.row item:ZZNotFound rank:ZZNotFound];
    }
    
    return [ZZIndexPath indexPathWithColumn:0 row:indexPath.row item:ZZNotFound rank:ZZNotFound];
}

@end

@implementation ZZIndexPath

+ (instancetype)indexPathWithColumn:(NSInteger)column row:(NSInteger)row item:(NSInteger)item rank:(NSInteger)rank{
    return [[self alloc] initWithColumn:column row:row item:item rank:rank];
}

- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row item:(NSInteger)item rank:(NSInteger)rank{
    if (self = [super init]) {
        self.column = column;
        self.row = row;
        self.item = item;
        self.rank = rank;
    }
    return self;
}

@end
