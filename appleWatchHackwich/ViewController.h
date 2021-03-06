//
//  ViewController.h
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblStudy;
@property (strong, nonatomic) IBOutlet UILabel *lblBreak;
@property (strong, nonatomic) IBOutlet UIView *detailsView;
@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UILabel *lblTimer;

@property NSTimeInterval studyTime;
@property NSTimeInterval breakTime;

@property NSInteger studySliderInt;
@property NSInteger breakSliderInt;
@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;
@property NSInteger ADD;
@property NSInteger Dys;
@property NSInteger sleep;

@property int timeSec;
@property int timeMin;

@property NSDate *initialDate;

@property (nonatomic)  NSTimer *timer;
@property (nonatomic)  NSTimer *breakTimerHasFinished;

@property BOOL isRestarting;
@property BOOL isPaused;
@end

