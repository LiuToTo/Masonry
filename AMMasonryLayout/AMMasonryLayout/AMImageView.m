//
//  AMImageView.m
//  AMMasonryLayout
//
//  Created by 刘ToTo on 16/8/30.
//  Copyright © 2016年 com.365ime. All rights reserved.
//

#import "AMImageView.h"

@interface AMImageView ()
{
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
@end

@implementation AMImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.2, 0.2, 0.2, 0.2);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
    NSString *bubblepath = [[NSBundle mainBundle] pathForResource:@"message_sender_background_highlight" ofType:@"png"];
    
    UIImage *bubbleimage = [UIImage imageWithContentsOfFile:bubblepath];
    UIImage * resizeImage = [bubbleimage resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 25, 40) resizingMode:UIImageResizingModeStretch];
    _maskLayer.contents = (id)resizeImage.CGImage;
    
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
}

- (void)setImage:(UIImage *)image
{
    _contentLayer.contents = (id)image.CGImage;
}
@end
