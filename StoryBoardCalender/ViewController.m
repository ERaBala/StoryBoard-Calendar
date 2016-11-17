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
    NSCalendar *calendar;
    NSDateComponents *components;
    
    NSMutableArray * MonthsArray, * NooFDaysInMonth, * StartingweekDateofMonth, * MonthArrayinFormate;
    NSMutableArray * dateForCount, * Dates ;
    int integers, NoFodays, i, SortCount;
    NSMutableArray * SecondArrayDays;
    NSArray * sortedDateArrayForSelection;
    NSString * selectionString ;
    NSMutableArray * CompareArrayValue;
    BOOL flag;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MonthsArray                 = [[NSMutableArray alloc] init];
    NooFDaysInMonth             = [[NSMutableArray alloc] init];
    StartingweekDateofMonth     = [[NSMutableArray alloc]init];
    Dates                       = [[NSMutableArray alloc]init];
    dateForCount                = [[NSMutableArray alloc]init];
    MonthArrayinFormate         = [[NSMutableArray alloc]init];
    CompareArrayValue           = [[NSMutableArray alloc] init];
    sortedDateArrayForSelection = [[NSArray alloc] init];
    
    
    _CollectionView.dataSource   = self;
    _CollectionView.delegate     = self;

    SortCount = 0;
    
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
        
        NSDateFormatter *DateFormate = [[NSDateFormatter alloc] init];
        NSString *monthName = [[DateFormate monthSymbols] objectAtIndex:(dateComp.month-1)];
        monthName = [NSString stringWithFormat: @"%@ %ld", monthName, (long)dateComp.year];
        
        /*      Number Of days in the month     */
        NoFodays = [self dateToFormatedDate:(long)dateComp.month Year:(long)dateComp.year];
        //        NSLog(@"%@ === in this year no of days === %d",monthName,NoFodays);
        
        NSString * firstDateOfMonth = [self weekCalculationFormatterFullStyle:(long)dateComp.month Year:(long)dateComp.year];
        
        /*  ADDING   */
        if (NoFodays != 0) {
            [NooFDaysInMonth addObject:[NSNumber numberWithInt: NoFodays]];
        }
        
        [MonthsArray addObject:monthName];
        [StartingweekDateofMonth addObject:firstDateOfMonth];
        
    }
    
    NSLog(@"%@",MonthsArray);
    
    NSLog(@"%@ \n\n %@ \n\n %@",MonthsArray,NooFDaysInMonth,StartingweekDateofMonth);
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.CollectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 1);
    
}

-(NSString *) weekCalculationFormatterFullStyle : (long)month Year:(long)year{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    // Start of week:
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp.day = 1;
    comp.month = month; // <-- fill in your week number here
    comp.year = year;    // <-- fill in your year here
    NSDate *startOfWeek = [cal dateFromComponents:comp];
    
    // Show results:
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateIntervalFormatterFullStyle;
    
    //    NSLog(@"%@", [fmt stringFromDate:startOfWeek]);   Starting of week
    //    NSLog(@"%@", [fmt stringFromDate:endOfWeek]);     Ending of week
    
    NSString *string = [fmt stringFromDate:startOfWeek];
    NSString *match = @",";
    NSString *preTel;
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanUpToString:match intoString:&preTel];
    //    NSLog(@"preTel: %@", preTel);                      Take week value alone line Sunday.. Monday..
    
    return preTel;
}

-(int)dateToFormatedDate:(long)month Year:(long)year {
    
    calendar = [NSCalendar currentCalendar];
    components = [[NSDateComponents alloc] init];
    
    // Set your year and month here
    [components setYear:year];
    [components setMonth:month];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    //    NSLog(@"%d", (int)range.length);
    return (int)range.length;
}

- (NSDate *)returnDateForMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day {
    
    components = [[NSDateComponents alloc] init];
    
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorian dateFromComponents:components];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell * Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //      next line will be connect to collection view image like @property */
    NSArray * arrayofMutable = [dateForCount objectAtIndex:indexPath.section];
    
    if([arrayofMutable count] > 0 && [arrayofMutable count] > indexPath.row){
        long checkValue = [[arrayofMutable objectAtIndex:indexPath.row]integerValue];
        
        if(checkValue == 0){
            
            Cell.Date.text = @" ";
            Cell.layer.borderWidth=1.0f;
            Cell.layer.borderColor=[UIColor whiteColor].CGColor;}
        else
        {
            Cell.Date.text = [[arrayofMutable objectAtIndex:indexPath.row] stringValue];
            Cell.layer.borderWidth=1.0f;
            Cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
           
        }
    }
    return Cell;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSString * week = [StartingweekDateofMonth objectAtIndex:section];
    NSString * Noofdays = [NooFDaysInMonth objectAtIndex:section];
    
    NSArray * emptyValueArray;
    NSInteger countr = [Noofdays integerValue];
    
    if ([week isEqualToString:@"Sunday"]) {
        SecondArrayDays = [[NSMutableArray alloc] init];
        for(integers = 1; integers <= countr; integers++) {
            [SecondArrayDays addObject:[NSNumber numberWithInt: integers]];
        }
        
        Dates = [NSMutableArray arrayWithArray:SecondArrayDays];
        [dateForCount addObject:Dates];
        
        return countr; }
    else if ([week isEqualToString:@"Monday"])
    {
        emptyValueArray = @[@0];
        SecondArrayDays = [[NSMutableArray alloc] init];
        for(integers = 1; integers <= countr; integers++) {
            [SecondArrayDays addObject:[NSNumber numberWithInt: integers]];
        }
        
        Dates = [NSMutableArray arrayWithArray:emptyValueArray];
        [Dates addObjectsFromArray: SecondArrayDays];
        [dateForCount addObject:Dates];
        
        return [Dates count];}
    else if ([week isEqualToString:@"Tuesday"])
    {
        emptyValueArray = @[@0,@0];
        SecondArrayDays = [[NSMutableArray alloc] init];
        for(integers = 1; integers <= countr; integers++) {
            [SecondArrayDays addObject:[NSNumber numberWithInt: integers]];
        }
        
        Dates = [NSMutableArray arrayWithArray:emptyValueArray];
        [Dates addObjectsFromArray: SecondArrayDays];
        [dateForCount addObject:Dates];
        
        return [Dates count];}
    else if ([week isEqualToString:@"Wednesday"])
    {
        emptyValueArray = @[@0,@0,@0];
        SecondArrayDays = [[NSMutableArray alloc] init];
        for(integers = 1; integers <= countr; integers++) {
            [SecondArrayDays addObject:[NSNumber numberWithInt: integers]];
        }
        
        Dates = [NSMutableArray arrayWithArray:emptyValueArray];
        [Dates addObjectsFromArray: SecondArrayDays];
        [dateForCount addObject:Dates];
        
        return [Dates count];}
    else if ([week isEqualToString:@"Thursday"])
    {
        emptyValueArray = @[@0,@0,@0,@0];
        SecondArrayDays = [[NSMutableArray alloc] init];
        for(integers = 1; integers <= countr; integers++) {
            [SecondArrayDays addObject:[NSNumber numberWithInt: integers]];
        }
        
        Dates = [NSMutableArray arrayWithArray:emptyValueArray];
        [Dates addObjectsFromArray: SecondArrayDays];
        [dateForCount addObject:Dates];
        
        return [Dates count];}
    else if ([week isEqualToString:@"Friday"])
    {
        emptyValueArray = @[@0,@0,@0,@0,@0];
        SecondArrayDays = [[NSMutableArray alloc] init];
        for(integers = 1; integers <= countr; integers++) {
            [SecondArrayDays addObject:[NSNumber numberWithInt: integers]];
        }
        
        Dates = [NSMutableArray arrayWithArray:emptyValueArray];
        [Dates addObjectsFromArray: SecondArrayDays];
        [dateForCount addObject:Dates];
        
        return [Dates count];}
    else
    {
        emptyValueArray = @[@0,@0,@0,@0,@0,@0];
        SecondArrayDays = [[NSMutableArray alloc] init];
        for(integers = 1; integers <= countr; integers++) {
            [SecondArrayDays addObject:[NSNumber numberWithInt: integers]];
        }
        
        Dates = [NSMutableArray arrayWithArray:emptyValueArray];
        [Dates addObjectsFromArray: SecondArrayDays];
        [dateForCount addObject:Dates];
        
        return [Dates count];}
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
