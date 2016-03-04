//
//  gameEndViewController.h
//  TrackBugApp
//
//  Created by wenbo on 12/8/15.
//  Copyright © 2015 WenboLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gameEndViewController : UIViewController

@property (weak, nonatomic) NSString * finalScore;
@property (weak, nonatomic) IBOutlet UILabel *finalScoreLabel;

- (IBAction)playAgain:(id)sender;
- (IBAction)homeButton:(id)sender;

@end

