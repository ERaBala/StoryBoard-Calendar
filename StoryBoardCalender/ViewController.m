//
//  ViewController.m
//  StoryBoardCalender
//
//  Created by Admin on 10/14/16.
//  Copyright © 2016 Erabala. All rights reserved.
//

#import "ViewController.h"
#import "CollectionReusableView.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Dates = [NSArray arrayWithObjects:@"1", @"2", @"3",@"4",@"5", @"6",@"7",@"8",@"9",@"10",@"11", @"12", @"13",@"14",@"15", @"16",@"17",@"18",@"19",@"20",@"21", @"22", @"23",@"24",@"25", @"26",@"27",@"28",@"29",@"30",@"31", nil];
    
    price = [NSArray arrayWithObjects:@"2312", @"35627", @"09872",@"99999",@"99999", @"99999",@"2312", @"35627", @"09872",@"99999",@"99999", @"99999",@"2312", @"35627", @"09872",@"99999",@"99999", @"99999",@"2312", @"35627", @"09872",@"99999",@"99999", @"99999",@"325908",@"",@"99999", @"99999",@"2312", @"35627", @"09872", nil];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.CollectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(3, 0, 20, 1);
    
 }


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    //  next line will be connect to collection view image like @property
    cell.Date.text = [Dates objectAtIndex:indexPath.row];
    cell.Price.text = [price objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [Dates count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%i", indexPath.section + 1];
        headerView.MonthLabel.text = title;
   
        headerView.layer.borderWidth=0.5f;
        headerView.layer.borderColor=[UIColor lightGrayColor].CGColor;

        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *november4th2012 = [[NSDateComponents alloc] init];
    [november4th2012 setYear:2012];
    [november4th2012 setMonth:11];
    [november4th2012 setDay:4];
    NSLog(@"%@", november4th2012);
    
    NSLog(@"dates");
    
}

@end
