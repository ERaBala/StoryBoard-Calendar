//
//  ViewController.h
//  StoryBoardCalender
//
//  Created by Admin on 10/14/16.
//  Copyright © 2016 Erabala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

@interface ViewController : UIViewController
{
    NSArray * Dates ;
    NSArray * price ;
}

@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;

@end

