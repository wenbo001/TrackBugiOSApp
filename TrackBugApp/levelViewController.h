//
//  levelViewController.h
//  TrackBugApp
//
//  Created by wenbo on 12/22/15.
//  Copyright © 2015 WenboLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface levelViewController : UIViewController
- (IBAction)levelOne:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *levelOneHighScore;

//@property (weak, nonatomic) IBOutlet UILabel* _score;
//@property (weak, nonatomic) IBOutlet UILabel* _highScore;

@end
