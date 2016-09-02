//
//  AMCollectionViewController.m
//  AMMasonryLayout
//
//  Created by 刘ToTo on 16/8/16.
//  Copyright © 2016年 com.365ime. All rights reserved.
//

#import "AMCollectionViewController.h"
#import "AMMasonryLayout.h"
#import "AMImageView.h"

#define HEXCOLOR(hexValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]
NSString * const kCollectionCellReuseID = @"kCollectionCellReuseID";

@interface AMCollectionViewController ()<AMMasonryLayoutDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AMCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    AMMasonryLayout *layout = [[AMMasonryLayout alloc] init];
    layout.delegate = self;
    layout.interItemVerticalSpacing = 8;
    layout.interItemHorazontalSpacing = 8;
    layout.numberOfColumns = 3;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.dataSource = self;
    [self.collectionView  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionCellReuseID];
    
    [self.view addSubview:self.collectionView];
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(AMMasonryLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = arc4random()%250 +130;
    return height >200 ? height :200;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellReuseID forIndexPath:indexPath];
    for (UIView *subview in cell.subviews) {
        [subview removeFromSuperview];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString *name = [NSString stringWithFormat:@"%u",arc4random()%13];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    
    CGRect frame = cell.bounds;
    frame.origin.x += 2;
    frame.origin.y += 2;
    frame.size.width -= 4;
    frame.size.height -= 4;
    
    AMImageView *imageView = [[AMImageView alloc] initWithFrame:frame];
    [imageView setImage:image];
    
    [cell addSubview:imageView];
//   CAShapeLayer * _maskLayer = [CAShapeLayer layer];
//    _maskLayer.fillColor = [UIColor blackColor].CGColor;
//    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
//    _maskLayer.frame = imageView.bounds;
//    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
//    _maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
//    _maskLayer.contents = (id)bubbleimage.CGImage;
//    
//    CALayer * _contentLayer = [CALayer layer];
//    _contentLayer.mask = _maskLayer;
//    _contentLayer.frame = imageView.bounds;
//    [imageView.layer addSublayer:_contentLayer];
//    
//    _contentLayer.contents = (id)image.CGImage;
    
    return cell;
}

@end
