//
//  AMMasonryLayout.m
//  AMMasonryLayout
//
//  Created by 刘ToTo on 16/8/16.
//  Copyright © 2016年 com.365ime. All rights reserved.
//

#import "AMMasonryLayout.h"

@interface AMMasonryLayout ()

@property (nonatomic, strong) NSMutableDictionary *bottomOfLastRow;
@property (nonatomic, strong) NSMutableDictionary *layoutInfos;

@end
@implementation AMMasonryLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.bottomOfLastRow = [NSMutableDictionary dictionary];
    self.layoutInfos = [NSMutableDictionary dictionary];
    
    CGFloat collectionWidth = self.collectionView.bounds.size.width;
    CGFloat availableWidth = collectionWidth - (self.numberOfColumns+1)* self.interItemHorazontalSpacing;
    CGFloat itemWidth = availableWidth / self.numberOfColumns;
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < numberOfSections; section++) {
         CGFloat numberOfItems = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger item; item < numberOfItems; item++) {
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            NSInteger column =  (item % self.numberOfColumns);
            CGFloat x = (self.interItemHorazontalSpacing + itemWidth) * column + self.interItemHorazontalSpacing;
            CGFloat y = [self.bottomOfLastRow[@(column)] doubleValue]+ self.interItemVerticalSpacing;
            if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForItemAtIndexPath:)]) {
                NSAssert(self.delegate || [self.delegate respondsToSelector:@selector(collectionView:layout:heightForItemAtIndexPath:)],@"id<AMMasonryLayoutDelegate> delegate must not be nil and collectionView:layout:heightForItemAtIndexPath: must be responds");
            }
            
            CGFloat height = [self.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];
            attribute.frame = CGRectMake(x, y, itemWidth, height);
            self.bottomOfLastRow[@(column)] = @(y + height);
            [self.layoutInfos setObject:attribute forKey:indexPath];
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:[self.layoutInfos count]];
    [self.layoutInfos enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * indexpath, UICollectionViewLayoutAttributes *attribute, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [attributes addObject:attribute];
        }
    }];
    
    return [attributes copy];
}

- (CGSize)collectionViewContentSize
{
    NSInteger column = 0;
    CGFloat maxHeight = 0;
    do {
        CGFloat height = [self.bottomOfLastRow[@(column)] doubleValue];
        maxHeight = maxHeight > height ? maxHeight : height;
        column++;
    } while (column < self.numberOfColumns);
    
    return CGSizeMake(self.collectionView.bounds.size.width, maxHeight);
}

@end
