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
    
    for (long month = thisMonth + 1; month <= 12; month++) {
        NSLog(@"%ld",month);
 
        if (month == 12) {
            thisMonth = 1;
        }else if (thisMonth == 11) {
            return ;
        }
    }
    
    [self getTodayFunction];
    [self monthCalculation];
    
    }


-(void) getTodayFunction{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE dd/MM/yyyy"];
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

- (IBAction)PrevMonth:(id)sender {
    

}

- (IBAction)NextMonth:(id)sender {
    
    
}

- (IBAction)LastDate:(id)sender {
    
/*    NSDate           *today           = [NSDate date];
    NSCalendar       *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];

    Nsin currentYear  = [components year];
    int currentmonth=[components month];
    NSLog(@"current Month %d",currentmonth);
    for(int months = currentmonth - 1; months < 12; months++)
        NSLog(@"%@ %i",[[dateFormatter monthSymbols]objectAtIndex: months],currentYear);*/
    
    
}
- (IBAction)ThisMonth:(id)sender {



}


@end
