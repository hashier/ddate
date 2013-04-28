//
//  MainViewController.m
//  ddate
//
//  Created by Christopher Loessl on 4/26/13.
//  Copyright (c) 2013 Christopher Loessl. All rights reserved.
//

#import "MainViewController.h"
#import "Ddate.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *discordianDateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *normalDatePicker;
@property (strong, nonatomic) Ddate *ddate;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.discordianDateLabel.numberOfLines = 4;
    self.ddate = [[Ddate alloc] init];
    [self normalDateChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)normalDateChanged {
    self.ddate.date = self.normalDatePicker.date;
    self.discordianDateLabel.text = [self.ddate ddate];
}

@end
