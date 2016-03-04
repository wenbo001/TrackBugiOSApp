//
//  levelViewController.m
//  TrackBugApp
//
//  Created by wenbo on 12/22/15.
//  Copyright © 2015 WenboLiu. All rights reserved.
//

#import "levelViewController.h"
#import "gameMainViewController.h"
#import "slGameData.h"

@interface levelViewController ()

@end

@implementation levelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Image"]]];
    [self startGame];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)levelOne:(id)sender {
    gameMainViewController * vcMain = [self.storyboard instantiateViewControllerWithIdentifier:@"gameMainNav"];
    [self presentViewController:vcMain animated:YES completion:nil];

}

//start gamedata
-(void)startGame {
    self.levelOneHighScore.text =[NSString stringWithFormat:@"BEST: %li", [slGameData sharedGameData].highScore];
}
@end
