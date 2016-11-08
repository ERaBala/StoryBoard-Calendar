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
    NSMutableArray * MonthsArray;
    NSArray * Dates, * febDates ;
    NSArray * price ;
    long thisMonth;
    long thisYear;
    int i;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MonthsArray = [[NSMutableArray alloc] init];
     
     NSDate *today = [NSDate date];
     NSDateComponents *dateComp = [[NSCalendar currentCalendar] components: NSCalendarUnitMonth | NSCalendarUnitYear fromDate:today];
    
    for (i = 0; i<12; i++) {
        if (i != 0) {
            [dateComp setMonth: dateComp.month + 1];
        }
      
        NSLog(@"Input Date: %@",dateComp);
        
        NSLog(@"%ld",(long)dateComp.month);

        if (dateComp.month > 12) {
            NSLog(@"%ld",(long)dateComp.month);
            switch (dateComp.month) {
                case 13: [dateComp setMonth:1]; break;
                case 14: [dateComp setMonth:2]; break;
                case 15: [dateComp setMonth:3]; break;
                case 16: [dateComp setMonth:4]; break;
                case 17: [dateComp setMonth:5]; break;
                case 18: [dateComp setMonth:6]; break;
                case 19: [dateComp setMonth:7]; break;
                case 20: [dateComp setMonth:8]; break;
                case 21: [dateComp setMonth:9]; break;
                case 22: [dateComp setMonth:10]; break;
                case 23: [dateComp setMonth:11]; break;
                default: break;
            }
            
            [dateComp setYear:dateComp.year + 1];
            NSLog(@"Month %ld %ld",(long)dateComp.month,(long)dateComp.year);
        }else{
            NSLog(@"Month %ld %ld",(long)dateComp.month,(long)dateComp.year);
        }
        
        // Set title for ReusableView in collection view
        NSDateFormatter *DateFormate = [[NSDateFormatter alloc] init];
        NSString *monthName = [[DateFormate monthSymbols] objectAtIndex:(dateComp.month-1)];
        monthName = [NSString stringWithFormat: @"%@ %ld", monthName, (long)dateComp.year];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM yyyy"];
        NSDate *monthCalculationDate = [dateFormat dateFromString:monthName];
        
        NSLog(@"%@",monthCalculationDate);
        
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:monthCalculationDate];
        NSLog(@"%@ == %d",dateComp,(int)range.length);
        
//        NSDate *today = [NSDate date]; //Get a date object for today's date
//        NSCalendar *c = [NSCalendar currentCalendar];
//        NSRange days = [c rangeOfUnit:NSDayCalendarUnit
//                               inUnit:NSMonthCalendarUnit
//                              forDate:today];
//        NSLog(@"%@ == %d",dateComp,(int)days.length);

        [MonthsArray addObject:monthCalculationDate];
       
    }
    
    NSLog(@"%@",MonthsArray);
    
    Dates = [NSArray arrayWithObjects:@"1", @"2", @"3",@"4",@"5", @"6",@"7",@"8",@"9",@"10",@"11", @"12", @"13",@"14",@"15", @"16",@"17",@"18",@"19",@"20",@"21", @"22", @"23",@"24",@"25", @"26",@"27",@"28",@"29",@"30",@"31", nil];
    
    febDates = [NSArray arrayWithObjects:@"1", @"2", @"3",@"4",@"5", @"6",@"7",@"8",@"9",@"10",@"11", @"12", @"13",@"14",@"15", @"16",@"17",@"18",@"19",@"20",@"21", @"22", @"23",@"24",@"25", @"26",@"27",@"28", nil];
    
    price = [NSArray arrayWithObjects:@" ", @"11111", @"22222",@"33333",@"44444", @"55555",@"66666", @"77777", @"88888",@"99999",@"98765", @"45789",@"2312", @"35627", @"09872",@"99999",@"99999", @"99999",@"2312", @"35627", @"09872",@"99999",@"99999", @"99999",@"77708",@"88888",@"99999", @"99999",@"2312", @"35627", @"09872", nil];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.CollectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 1);
    
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
    cell.Date.textColor = [UIColor colorWithRed:180.0/255.0 green:6.0/255.0 blue:47.0/255.0 alpha:1.0];
    cell.Date.font = [UIFont fontWithName:@"American Typewriter" size:18];
    
    cell.Price.text = [price objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
/**/
//     Need to check for error...
 
    NSString * dateOnly = [self dateToFormatedDate:MonthsArray[section]];
    
//    MonthsArray[section];
    NSLog(@"%@",dateOnly);
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
//    NSDate *date = [dateFormat dateFromString:dateOnly];
//    NSLog(@"%@",date);
   return 30;
}

-(NSString *)dateToFormatedDate:(NSString *)dateStr {
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:@"EE, d MMM, YYYY"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark - UICollectionReusableView

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader)
    {
        CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        
        headerView.MonthLabel.text = [MonthsArray objectAtIndex:indexPath.section];
        headerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        reusableview = headerView;
    }
    return reusableview;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor clearColor]; // Default color
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor lightGrayColor]; // highlight selection
    NSLog(@"%@",[MonthsArray objectAtIndex:indexPath.section]);
    
}


-(NSInteger *)countDaysinMonth :(NSInteger *) monthinnumbers{
    
    calendar = [NSCalendar currentCalendar];
    
    // Set your year and month here
    [components setYear:2015];
    [components setMonth:1];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    NSLog(@"%d", (int)range.length);
    return 1;
}
@end
