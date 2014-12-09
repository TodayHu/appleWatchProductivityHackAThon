//
//  InterfaceController.m
//  appleWatchHackwich WatchKit Extension
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "InterfaceController.h"
#import "UserInfoViewController.h"

@interface InterfaceController()
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnStartStop;
@property (strong, nonatomic) IBOutlet WKInterfaceTimer *lblTimer;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnPause;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnRestart;

@property NSTimeInterval studyTime;
@property NSTimeInterval breakTime;
@property (nonatomic)  NSTimer *timerHasFinished;
@property NSDate *initialDate;

@property BOOL isRestarting;
@property BOOL isPaused;

@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;
@property NSInteger studySliderInt;
@property NSInteger breakSliderInt;

@end

@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        NSLog(@"%@ initWithContext", self);
        //self. = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

        self.isRestarting = false;
        self.isPaused = false;
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

- (IBAction)onStartStopTimer {
    [self.btnStartStop setEnabled:NO];

    [self startTImer];
}

- (void)startTImer {
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    NSInteger newAge = [currentSettings integerForKey:@"CurrentAge"];
    NSInteger newGender = [currentSettings integerForKey:@"CurrentGender"];
    NSInteger newADHD = [currentSettings integerForKey:@"CurrentADHD"];
    NSInteger newStudy = [currentSettings integerForKey:@"CurrentStudyInt"];
    NSInteger newBreak = [currentSettings integerForKey:@"CurrentBreakInt"];

    self.age = newAge;
    self.gender = newGender;
    self.ADHD = newADHD;
    self.studySliderInt = newStudy;
    self.breakSliderInt = newBreak;

    NSLog(@"1 Current Age %ld", (long)self.age);
    NSLog(@"1 Current Gender %ld", (long)self.gender);
    NSLog(@"1 Current ADHD %ld", (long)self.ADHD);
    NSLog(@"1 Current Study %ld", (long)self.studySliderInt);
    NSLog(@"1 Current Break %ld", (long)self.breakSliderInt);


    // if ((self.studySliderInt == 0) && (self.breakSliderInt == 0)) {
    self.studyTime = 20;
    self.breakTime = 5;
    NSLog(@"Current Age %ld", (long)self.age);
    //  } else {

    //      self.studyTime = self.studySliderInt;
    //      self.breakTime = self.breakSliderInt;

    if (self.age < 12) {
        self.studyTime = self.studyTime + 100;
        self.breakTime = self.breakTime + 0;
        NSLog(@"12 Productivity TIme %.2f minutes", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if (self.age >= 13 && self.age <= 24) {
        self.studyTime = self.studyTime + 90;
        self.breakTime = self.breakTime + 5;
        NSLog(@"13 - 24 Productivity TIme %.2f minutes", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if (self.age >= 25 && self.age <= 30) {
        self.studyTime = self.studyTime + 80;
        self.breakTime = self.breakTime + 10;
        NSLog(@"25 - 30 Productivity TIme %.2f minutes", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if (self.age >= 31 && self.age <= 35) {
        self.studyTime = self.studyTime + 70;
        self.breakTime = self.breakTime + 20;
        NSLog(@"31 - 35 Productivity TIme %.2f minutes", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    }

    if (self.gender == 0) {
        self.studyTime = self.studyTime + 6;
        NSLog(@"Male Productivity TIme %.2f minutes", self.studyTime);
    } else {
        self.studyTime = self.studyTime + 9;
        NSLog(@"Female Productivity TIme %.2f minutes", self.studyTime);
    }

    if (self.ADHD == 0) {
        self.studyTime = self.studyTime + 0;
        NSLog(@"w/o ADHD Productivity TIme %.2f minutes", self.studyTime);
    } else {
        self.studyTime = self.studyTime + 15;
        NSLog(@"W/ ADHD Productivity TIme %.2f minutes", self.studyTime);
    }

    NSLog(@"Current Study Time %.0f \n", self.studyTime);

    if (self.isRestarting == false) {
        self.studyTime = self.studyTime * 20;
        self.initialDate = [[NSDate alloc] initWithTimeIntervalSinceNow:self.studyTime];
        [self.lblTimer setDate:self.initialDate];
        [self.btnStartStop setColor:[UIColor colorWithRed:0.29 green:0.4 blue:0.62 alpha:1]];
        [self.btnStartStop setTitle:@"Study Time!"];
    } else if (self.isRestarting == true) {
        self.breakTime = self.breakTime * 20;
        self.initialDate = [[NSDate alloc] initWithTimeIntervalSinceNow:self.breakTime];
        [self.lblTimer setDate:self.initialDate];
        [self.btnStartStop setColor:[UIColor colorWithRed:0.29 green:0.4 blue:0.62 alpha:1]];
        [self.btnStartStop setTitle:@"Break time!!"];
    }

    [self.lblTimer start];
    [self.lblTimer setDate:self.initialDate];

    self.timerHasFinished = [NSTimer scheduledTimerWithTimeInterval:self.studyTime
                                                             target:self
                                                           selector:@selector(doneWorking:)
                                                           userInfo:nil
                                                            repeats:false];
}
//}

-(void)doneWorking:(NSTimer *)timer{
    [self.btnStartStop setEnabled:YES];
    if (self.isRestarting == false) {
        [self.btnStartStop setColor:[UIColor colorWithRed:0.19 green:0.22 blue:0.36 alpha:1]];
        [self.btnStartStop setTitle:@"Take a Break!"];
        self.isRestarting = true;
    } else if (self.isRestarting == true) {
        [self.btnStartStop setColor:[UIColor colorWithRed:0.82 green:0.89 blue:0.95 alpha:1]];
        [self.btnStartStop setTitle:@"Back to Study!"];
        self.isRestarting = false;
    }
}

- (IBAction)onPause{
    if (self.isPaused == false) {
        [self.lblTimer stop];
        [self.btnPause setTitle:@"Resume"];
        self.isPaused = true;
    } else if (self.isPaused == true){
        [self.lblTimer start];
        [self.btnPause setTitle:@"Pause"];
        self.isPaused = false;
    }
}
- (IBAction)onRestart {
    [self startTImer];
}
@end