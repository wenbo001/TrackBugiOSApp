//
//  gameMainViewController.h
//  TrackBugApp
//
//  Created by wenbo on 12/8/15.
//  Copyright © 2015 WenboLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gameMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
//@property (weak, nonatomic) IBOutlet UILabel *lifeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITextView *codeTextView;

//count
@property NSInteger lifeCount;
@property NSInteger scoreCount;

@property NSInteger yourScore;

//timer
@property NSInteger seconds;
@property NSTimer *timer;

//function
-(void) setupApp;
-(void) subtractTime;

@end
