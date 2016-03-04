//
//  gameEndViewController.m
//  TrackBugApp
//
//  Created by wenbo on 12/8/15.
//  Copyright © 2015 WenboLiu. All rights reserved.
//

#import "gameEndViewController.h"
#import "gameMainViewController.h"
#import "languageViewController.h"
#import "slGameData.h"

@interface gameEndViewController ()

@end

@implementation gameEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Image"]]];
    self.finalScoreLabel.text = [NSString stringWithFormat:@"%@",self.finalScore];;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)playAgain:(id)sender {
    
    gameMainViewController * vcmain = [self.storyboard instantiateViewControllerWithIdentifier:@"gameMainNav"];
    [self presentViewController:vcmain animated:YES completion:nil];
}

- (IBAction)homeButton:(id)sender {
    languageViewController * vcLan= [self.storyboard instantiateViewControllerWithIdentifier:@"languageNav"];
    [self presentViewController:vcLan animated:YES completion:nil];
}

@end

