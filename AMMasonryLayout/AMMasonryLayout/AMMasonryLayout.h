//
//  AMMasonryLayout.h
//  AMMasonryLayout
//
//  Created by 刘ToTo on 16/8/16.
//  Copyright © 2016年 com.365ime. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMMasonryLayout;
@protocol AMMasonryLayoutDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(AMMasonryLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface AMMasonryLayout : UICollectionViewLayout

@property (nonatomic, assign) NSUInteger numberOfColumns;

@property (nonatomic, assign) CGFloat interItemVerticalSpacing;
@property (nonatomic, assign) CGFloat interItemHorazontalSpacing;
@property (nonatomic, weak) id<AMMasonryLayoutDelegate> delegate;

@end
