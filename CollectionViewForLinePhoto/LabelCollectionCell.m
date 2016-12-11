//
//  LabelCollectionCell.m
//  CollectionViewForLinePhoto
//
//  Created by mac on 16/12/11.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "LabelCollectionCell.h"

@interface LabelCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LabelCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.cornerRadius = 3;
    self.imageView.layer.borderWidth = 2;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.clipsToBounds = YES;
    self.backgroundColor = [UIColor yellowColor];
}

- (void)setIndex:(NSString *)index {
    _index = index;
    self.imageView.image = [UIImage imageNamed:_index];
}

@end
