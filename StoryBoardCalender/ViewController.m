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
{
    NSDateComponents *components;
    NSCalendar *calendar;
    long thisMonth;
    long thisYear;
    int i;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Dates = [NSArray arrayWithObjects:@" ", @"2", @"3",@"4",@"5", @"6",@"7",@"8",@"9",@"10",@"11", @"12", @"13",@"14",@"15", @"16",@"17",@"18",@"19",@"20",@"21", @"22", @"23",@"24",@"25", @"26",@"27",@"28",@"29",@"30",@"31", nil];
    
    febDates = [NSArray arrayWithObjects:@" ", @"2", @"3",@"4",@"5", @"6",@"7",@"8",@"9",@"10",@"11", @"12", @"13",@"14",@"15", @"16",@"17",@"18",@"19",@"20",@"21", @"22", @"23",@"24",@"25", @"26",@"27",@"28", nil];
    
    price = [NSArray arrayWithObjects:@" ", @"35627", @"09872",@"99999",@"99999", @"99999",@"2312", @"35627", @"09872",@"99999",@"99999", @"99999",@"2312", @"35627", @"09872",@"99999",@"99999", @"99999",@"2312", @"35627", @"09872",@"99999",@"99999", @"99999",@"325908",@"",@"99999", @"99999",@"2312", @"35627", @"09872", nil];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.CollectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(3, 0, 20, 1);
    
    thisYear = [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]] year];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    components = [cal components:NSCalendarUnitMonth fromDate:[NSDate date]];
    thisMonth=[components month];
 }


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
/*    for ( ; i < Dates.count; i++) {
        if ([Dates[i]  isEqual: @" "]) {
       
            NSLog(@"Nothing ");
        }else{}
    }
  */
    
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
//    if (self.selectedItemIndexPath != nil && [indexPath compare:self.selectedItemIndexPath] == NSOrderedSame) {
//        cell.layer.borderColor = [[UIColor redColor] CGColor];
//        cell.layer.borderWidth = 4.0;
//    } else {
//        cell.layer.borderColor = nil;
//        cell.layer.borderWidth = 0.0;
//    }
    
//    if (cell.selected) {
//        cell.backgroundColor = [UIColor blueColor]; // highlight selection
//    }
//    else
//    {
//        cell.backgroundColor = [UIColor whiteColor]; // Default color
//    }
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

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor whiteColor]; // Default color
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor lightGrayColor]; // highlight selection
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLog(@"%@ %ld ", [[formatter monthSymbols] objectAtIndex:indexPath.section], thisYear);
}

#pragma mark - UICollectionReusableView

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader) {
    
        CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM yyyy"];
        NSString *dateString = [dateFormat stringFromDate:today];
        
        NSDate *generatedDate = [dateFormat dateFromString:dateString];
//        NSLog(@"%@", [dateFormat stringFromDate:generatedDate]);
//        NSLog(@"date: **** 8888 **** %@", generatedDate);
       
        
         
//         NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *dateComp = [[NSCalendar currentCalendar] components: NSCalendarUnitMonth | NSCalendarUnitYear fromDate:today];
        [dateComp setMonth: dateComp.month + indexPath.section];
        NSLog(@"Input Date: %@",dateComp);
        if (dateComp.month > 12) {
            if (dateComp.month >= 13) {
                int i = dateComp.month - 1;
                [dateComp setMonth:1];
                NSLog(@"(((((((((((((((((( ******* ******* ********* ))))))))))))))))))) ");
            }
            [dateComp setYear:dateComp.year + 1];
            NSLog(@"Month %ld %ld",(long)dateComp.month,(long)dateComp.year);
        }else{
        NSLog(@"Month %ld %ld",(long)dateComp.month,(long)dateComp.year);
        }
        
        /*
         [dateComp setMonth:dateComp.month + 1];
         
         if (dateComp.month > 12) {
         [dateComp setYear:dateComp.year + 1];
         NSLog(@"Month %ld %ld",(long)dateComp.month,dateComp.year);
         }
         
         NSDate *nextMonthMinusOneday = [gregorian dateFromComponents:dateComp];
         
         NSLog(@"Output date %@",nextMonthMinusOneday);

         
         */
        
/*
#warning Check UIScrollViewDelegate 
        
        CGPoint translation = [collectionView.panGestureRecognizer translationInView:collectionView.superview];
        if (translation.y > 0) {
            NSLog(@"up");
            [self UpdateCalendarMonthYearup];
        } else {
            NSLog(@"Down");
            [self UpdateCalendarMonthYeardown];
        }
*/
//        [self UpdateCalendarMonthYear:indexPath.section + 1];
       
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSLog(@"%@",[[formatter monthSymbols] objectAtIndex:(thisMonth - 1)]);
        
        // Set title for ReusableView in collection view
            NSString *title = [[NSString alloc]initWithFormat:@"%@ %ld ", [[formatter monthSymbols] objectAtIndex:indexPath.section], (long)dateComp.year]; //%i", indexPath.section + 1
            headerView.MonthLabel.text = title;

        
//        headerView.layer.borderWidth=0f;
        headerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
        reusableview = headerView;
    }
    
    return reusableview;
}

-(NSString *)monthinwords:(NSInteger *) monthinnumbers{
    
    long monthNumber = *monthinnumbers;
    NSString * dateString = [NSString stringWithFormat: @"%ld", monthNumber];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSDate* myDate = [dateFormatter dateFromString:dateString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    NSString *stringFromDate = [formatter stringFromDate:myDate];
    
    return stringFromDate;
}

-(void) UpdateCalendarMonthYear: (long *) some{
    
    if(thisMonth>12){ thisMonth=1; thisYear++; }
    if(thisMonth<1) { thisMonth=12; thisYear--; }
}

-(void) UpdateCalendarMonthYearup{
    
    if(thisMonth>1){
        thisMonth=1;
        thisYear--;
    }
    
    if(thisMonth<12){
        thisMonth=12;
        thisYear++;
    }
}

-(void) UpdateCalendarMonthYeardown{
    
    if(thisMonth>12){
        thisMonth=1;
        thisYear++;
    }
    
    if(thisMonth<1){
        thisMonth=12;
        thisYear--;
    }
}



#pragma mark - UIScrollViewDelegate
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.lastContentOffset > scrollView.contentOffset.y)
    {
        [self UpdateCalendarMonthYearup];
    }
    else if (self.lastContentOffset < scrollView.contentOffset.y)
    {
        [self UpdateCalendarMonthYeardown];
    }
    
    self.lastContentOffset = scrollView.contentOffset.y;
}
*/

@end
