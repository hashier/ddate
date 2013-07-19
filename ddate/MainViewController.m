//
//  MainViewController.m
//  ddate
//
//  Created by Christopher Loessl on 4/26/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#import "MainViewController.h"
#import "NSDate+ddate.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *discordianDateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *normalDatePicker;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self normalDateChanged];
}

- (IBAction)normalDateChanged {
    self.discordianDateLabel.text = [self.normalDatePicker.date ddate];
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    self.normalDatePicker.date = [self.normalDatePicker.date dateByAddingTimeInterval:-60*60*24*1];
    [self normalDateChanged];
}

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender {
    self.normalDatePicker.date = [self.normalDatePicker.date dateByAddingTimeInterval:60*60*24*1];
    [self normalDateChanged];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        self.normalDatePicker.date = [NSDate date];
        [self normalDateChanged];
    }
}

@end
