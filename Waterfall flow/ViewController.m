//
//  ViewController.m
//  Waterfall flow
//
//  Created by 黄梓伦 on 3/17/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "ViewController.h"
#import "HZLShopCell.h"
#import "HZLWaterFallLayout.h"
static NSString *shopID = @"shop";

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HZLWaterFallLayout *layout = [[HZLWaterFallLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[HZLShopCell class] forCellWithReuseIdentifier:shopID];
    
}


//并没有在这里告知所有的大小
#pragma mark - 协议方法
/**
 返回50个
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZLShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopID forIndexPath:indexPath];
    
    cell.textName = [NSString stringWithFormat:@"%ld", indexPath.item];
    
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}


@end
