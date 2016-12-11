//
//  ViewController.m
//  CollectionViewForLinePhoto
//
//  Created by mac on 16/12/11.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "ViewController.h"
#import "LabelCollectionCell.h"
#import "LinePhotoCollectionViewFlowLayout.h"
#import "SecondViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString *const cellId = @"cellId";


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self collectionView];
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        LinePhotoCollectionViewFlowLayout *flowLayout = [[LinePhotoCollectionViewFlowLayout alloc] init];
//        flowLayout.minimumLineSpacing = 50;
//        flowLayout.minimumInteritemSpacing = 50;
//        flowLayout.sectionInset = UIEdgeInsetsMake(50, 50, 50, 50);
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 180) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LabelCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:cellId];
        [self.view addSubview:_collectionView];
    }
    
    return  _collectionView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        NSMutableArray *dataSource = [[NSMutableArray alloc] init];
        for (NSInteger i = 7; i < 230; i ++) {
            NSString *item = [NSString stringWithFormat:@"%00.3ld.JPG",i];
            if ([UIImage imageNamed:item]) {
                NSLog(@"===%@",item);
                [dataSource addObject:item];
            }
        }
        _dataSource = [dataSource copy];
    }

    return _dataSource;
}


#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LabelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.index = self.dataSource[indexPath.item];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LabelCollectionCell *cell = (LabelCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    vc.image = cell.index;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    LabelCollectionCell *cell = (LabelCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.index = self.dataSource[indexPath.item];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
