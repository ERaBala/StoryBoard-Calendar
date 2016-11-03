//
//  ViewController.h
//  StoryBoardCalender
//
//  Created by Admin on 10/14/16.
//  Copyright © 2016 Erabala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

@interface ViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * Dates, * febDates ;
    NSArray * price ;
}

@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;
@property (nonatomic) CGFloat lastContentOffset;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;

@end

