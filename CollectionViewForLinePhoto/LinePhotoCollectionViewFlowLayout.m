//
//  LinePhotoCollectionViewFlowLayout.m
//  CollectionViewForLinePhoto
//
//  Created by mac on 16/12/11.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "LinePhotoCollectionViewFlowLayout.h"

static const CGFloat kItemSize = 100;

@implementation LinePhotoCollectionViewFlowLayout
-(instancetype)init {
    if (self = [super init]) {
        
    }

    return self;
}

-(void)prepareLayout {
    [super prepareLayout];
    self.minimumLineSpacing = 60;
    self.itemSize = CGSizeMake(kItemSize, kItemSize);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, (self.collectionView.frame.size.width - kItemSize) / 2, 0, (self.collectionView.frame.size.width - kItemSize) / 2);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {

    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@"%@",NSStringFromCGRect(rect));
    NSLog(@"开始");
    NSLog(@"----");
    NSLog(@"结束");
    
    CGRect visiableRect ;
    visiableRect.origin = self.collectionView.contentOffset;
    visiableRect.size = self.collectionView.frame.size;
    CGFloat screenCenterX = visiableRect.origin.x + visiableRect.size.width / 2; //控件中点
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        if (CGRectIntersectsRect(attribute.frame, visiableRect)) {//如果可见
            CGFloat attributeCenterX = attribute.center.x;
            
            CGFloat scale = 1 + (1 - ABS(attributeCenterX - screenCenterX) / visiableRect.size.width) * 0.5;
            
            attribute.transform = CGAffineTransformMakeScale(scale, scale);
            
            
        }
        
    }
    
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    //最后的位置
    CGRect lastRect ;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    CGFloat lastCenterX = lastRect.origin.x + lastRect.size.width / 2;
    //拿到最后位置的属性数组
    NSArray *attributes = [self layoutAttributesForElementsInRect:lastRect];
    
    //找出离中心最近的item
    CGFloat minSpace = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        CGFloat space = attribute.center.x - lastCenterX;
        if (ABS(minSpace) > ABS(space)) {
            minSpace = space;
        }
    }
    
    CGPoint resultPoint = CGPointMake(proposedContentOffset.x + minSpace, proposedContentOffset.y);
    return resultPoint;
}


@end
