//
//  ViewController.m
//  TrackBugApp
//
//  Created by wenbo on 2/1/16.
//  Copyright © 2016 WenboLiu. All rights reserved.
//

#import "ViewController.h"
#import "introViewController.h"
@interface ViewController ()
- (IBAction)playButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playButtonText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Image"]]];
    //title
    UITextView * titleText;
    CGRect titleTextFrame;
    self.playButtonText.alpha = 0;
    
    titleText = [[UITextView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-150, -120, 300, 60)];
    [titleText setTextAlignment:NSTextAlignmentCenter];
    titleText.backgroundColor = nil;
    titleText.text = @"TRACK BUG";
    titleText.textColor = [UIColor whiteColor];
    titleText.font = [UIFont fontWithName:@"Thirteen Pixel Fonts" size:36.0];
    titleText.editable = NO;
    titleText.selectable = NO;
    [self.view addSubview:titleText];
    titleTextFrame = titleText.frame;
    titleTextFrame.origin.y = 210;
    [UIView animateWithDuration:1.0
                          delay:0.5
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         titleText.frame = titleTextFrame;
                     }
                     completion:^(BOOL finished){
                         self.playButtonText.alpha = 1;
                     }];

   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)playButton:(id)sender {
    introViewController * vc= [self.storyboard instantiateViewControllerWithIdentifier:@"introNav"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
