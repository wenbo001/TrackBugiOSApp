//
//  languageViewController.m
//  TrackBugApp
//
//  Created by wenbo on 12/9/15.
//  Copyright © 2015 WenboLiu. All rights reserved.
//

#import "languageViewController.h"
#import "levelViewController.h"

@interface languageViewController ()

@end

@implementation languageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Image"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)languageButton:(id)sender {
    levelViewController * vcLevel = [self.storyboard instantiateViewControllerWithIdentifier:@"levelNav"];
    [self presentViewController:vcLevel animated:YES completion:nil];
}
@end

