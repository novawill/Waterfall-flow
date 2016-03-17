//
//  HZLWaterFallLayout.m
//  Waterfall flow
//
//  Created by 黄梓伦 on 3/17/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLWaterFallLayout.h"


/**
 *  列数
 */
static NSInteger HZLColumnCount = 4;

/**
 *  行间距
 */
static CGFloat HZLRowMargin = 10;

/**
 *  列间距
 */
static CGFloat HZLColumnMargin = 10;


/**
 *  边距
 */
static UIEdgeInsets HZLEdgeInsets = {10, 10, 10, 10};


@interface HZLWaterFallLayout ()

@property (nonatomic, strong) NSMutableArray *maxYs;

@property (nonatomic, strong) NSMutableArray *attrs;

@end

@implementation HZLWaterFallLayout 



//两个数据一个保存高度 一个保存各个item的形状属性
- (NSMutableArray *)maxYs
{
    if (!_maxYs) {
        _maxYs = [[NSMutableArray alloc] init];
    }
    return _maxYs;
}

- (NSMutableArray *)attrs
{
    if (!_attrs) {
        _attrs = [[NSMutableArray alloc] init];
    }
    return _attrs;
}



//初始化 工作
- (void)prepareLayout
{
    [super prepareLayout];
    
    //清除当前的高度
    [self.maxYs removeAllObjects];
    
    //添加 三个 10上边距
    
    for (int i = 0; i < HZLColumnCount; i++) {
        
        [self.maxYs addObject:@(HZLEdgeInsets.top)];
        //10 10 10
    }
    
    
    //获得总数拿到每个的attrs
    NSInteger totalCount = [self.collectionView numberOfItemsInSection:0];
    //遍历获取
    
    for (int i = 0; i < totalCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrs addObject:attrs];
    }
    
    
    
}



//调用这个计算
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //第。。。个indexPath
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //计算
    //获得宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    //cell宽度
    CGFloat w = ((collectionViewW - HZLEdgeInsets.left - HZLEdgeInsets.right) - (HZLColumnCount - 1) * HZLColumnMargin)/HZLColumnCount;
    
    //cell高度
    CGFloat h = arc4random() % 50 + 100;
    
    //y
    //假设第一个最高
    NSInteger destColumn = 0;
    CGFloat minHeight = [self.maxYs[0] doubleValue];
    
    for (int i = 1; i < HZLColumnCount; i++) {
        
        CGFloat height = [self.maxYs[i] doubleValue];
        
        if (height < minHeight) {
            minHeight = height;
            destColumn = i;
        }
        
    }
    
    CGFloat y = minHeight;
    
    if (y != HZLEdgeInsets.top) {
        y += HZLRowMargin;
    }
    
    
    CGFloat x = HZLEdgeInsets.left + destColumn *(w + HZLColumnMargin);
    
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    NSLog(@"%@", NSStringFromCGRect(attrs.frame));
    
    
    self.maxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}


//布局
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrs;
}


//contentSize
- (CGSize)collectionViewContentSize
{
    CGFloat maxColumnHeight = [self.maxYs[0] doubleValue];
    for (NSInteger i = 1; i < HZLColumnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.maxYs[i] doubleValue];
        
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    
    
    return CGSizeMake(0, maxColumnHeight + HZLEdgeInsets.bottom);
    
}

@end
