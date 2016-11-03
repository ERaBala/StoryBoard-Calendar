//
//  CalendarLogVC.m
//  StoryBoardCalender
//
//  Created by Admin on 11/1/16.
//  Copyright © 2016 Erabala. All rights reserved.
//

#import "CalendarLogVC.h"

@interface CalendarLogVC ()
{
    
    NSDateComponents *components;
    NSCalendar *calendar;
    long thisMonth;
    long thisYear;

}
@end

@implementation CalendarLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
        calendar = [NSCalendar currentCalendar];
        components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
     thisYear = [components year];
     thisMonth = [components month];
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
    NSInteger day = [dateComponents month];
    
    
    for (int month = 1; month <= 12; month++) {
        
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM yyyy"];
        NSString *dateString = [dateFormat stringFromDate:today];
        NSLog(@"date: **** 8888 **** %@ **** %d", dateString,month );
        
        NSLog(@"%ld",(long)day+1);

    } 
    
    [self getTodayFunction];
    
    }


-(void) getTodayFunction{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE MMM yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSLog(@"date: **** 8888 **** %@", dateString);

}


-(void) monthCalculation{

    // Set your year and month here
    [components setYear:thisYear];
    [components setMonth:thisMonth];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    NSLog(@"Days = = = = = = = =  %d", (int)range.length);

}


-(void)monthInWords{
    
  
    NSString *dateStr = @"2011-08-26";
    //if you have date then,
    dateStr = [NSString stringWithFormat:@"%@",dateStr];
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    [dateFormat setDateFormat:@"MMMM dd, YYYY"];
    NSString* temp = [dateFormat stringFromDate:date];
    
    
    
    NSLog(@"%@",temp);


}
-(void)thisMonthCount{
    
    NSCalendar *cal = [NSCalendar autoupdatingCurrentCalendar];
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    NSLog(@"%lu",(unsigned long)numberOfDaysInMonth);
    NSLog(@"my range is %@", NSStringFromRange(range));
}

- (IBAction)PrevMonth:(id)sender {
    

}

- (IBAction)NextMonth:(id)sender {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];

    NSLog(@"Input Date: %@",[NSDate date]);
    
    
    [dateComp setMonth:dateComp.month + 1];
    
    if (dateComp.month > 12) {
        [dateComp setYear:dateComp.year + 1];
        NSLog(@"Month %ld %ld",(long)dateComp.month,dateComp.year);
    }
    
    NSDate *nextMonthMinusOneday = [gregorian dateFromComponents:dateComp];
    
    NSLog(@"Output date %@",nextMonthMinusOneday);
    
}

- (IBAction)LastDate:(id)sender {
/*    
 
    NSDate           *today           = [NSDate date];
    NSCalendar       *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];

    Nsin currentYear  = [components year];
    int currentmonth=[components month];
    NSLog(@"current Month %d",currentmonth);
    for(int months = currentmonth - 1; months < 12; months++)
 {
     NSLog(@"%@ %i",[[dateFormatter monthSymbols]objectAtIndex: months],currentYear);
 }
 
 */
}


- (IBAction)ThisMonth:(id)sender {

}


@end
