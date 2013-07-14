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
@property (strong, nonatomic) NSDate *date;
@end

@implementation MainViewController

- (NSDate *)ddate {
    if (!_date) _date = [[NSDate alloc] init];
    return _date;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self normalDateChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)normalDateChanged {
    self.date = self.normalDatePicker.date;
    self.discordianDateLabel.text = [self.date ddate];
}

@end
