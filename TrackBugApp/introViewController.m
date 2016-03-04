//
//  ViewController.m
//  TrackBugApp
//
//  Created by wenbo on 12/8/15.
//  Copyright © 2015 WenboLiu. All rights reserved.
//

#import "introViewController.h"
#import "languageViewController.h"

@interface introViewController ()

@property (weak, nonatomic) IBOutlet UITextView *introTextView;
@property (weak, nonatomic) IBOutlet UILabel *theHeader;
@property (weak, nonatomic) IBOutlet UIButton *theStart;

- (IBAction)exBugButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *exBug;

@end

@implementation introViewController

UITextView * welldoneText;
CGRect welldoneTextFrame;

BOOL blinkStatus = NO;
NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Image"]]];
    
    self.introTextView.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BgCloud"]];
    imageView.frame = CGRectMake(0, self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height/2);
    [self.view addSubview:imageView];
    [self.view bringSubviewToFront:self.introTextView];
    [self.view bringSubviewToFront:self.exBug];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //welldone
    welldoneText = [[UITextView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-150, self.view.frame.size.height *1.5, 300, 60)];
    [welldoneText setTextAlignment:NSTextAlignmentCenter];
    welldoneText.backgroundColor = nil;
    welldoneText.text = @"Well Done";
    welldoneText.textColor = [UIColor whiteColor];
    welldoneText.font = [UIFont fontWithName:@"Thirteen Pixel Fonts" size:36.0];
    welldoneText.editable = NO;
    welldoneText.selectable = NO;
    [self.view addSubview:welldoneText];
    
    welldoneTextFrame = welldoneText.frame;
    welldoneTextFrame.origin.y = self.view.frame.size.height/2+30;
    
    self.theHeader.alpha = 0;
    self.theStart.alpha = 0;
    self.introTextView.alpha = 0;
    self.exBug.alpha = 0;
    welldoneText.alpha = 0;
   
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.introTextView.alpha = 1.0;
                         self.introTextView.editable = NO;
                         self.introTextView.selectable = NO;
                                  }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5
                                               delay:0.5
                                             options: UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.theHeader.alpha = 1.0;
                      }completion:^(BOOL finished) {
                          
                          [UIView animateWithDuration:0.0
                                                delay:1.5
                                              options: UIViewAnimationOptionCurveEaseInOut
                                           animations:^{
                        
                                               self.exBug.alpha = 1.0f;

                                           }completion:^(BOOL finished) {
                                               timer = [NSTimer
                                                        scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0)
                                                        target:self
                                                        selector:@selector(blink)
                                                        userInfo:nil
                                                        repeats:TRUE];
                                           }];
                         
                        }];
    }];
}

-(void)blink{
    if(blinkStatus == NO){
        self.exBug.alpha = 0.01;
        blinkStatus = YES;
    }else {
        self.exBug.alpha = 1;
        blinkStatus = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)gameMainAction:(id)sender {
//    NSString * storyboardName = @"Main";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"navLanguage"];
//    [self presentViewController:vc animated:YES completion:nil];
    languageViewController * vclan = [self.storyboard instantiateViewControllerWithIdentifier:@"languageNav"];
    [self presentViewController:vclan animated:YES completion:nil];
}

- (IBAction)exBugButton:(id)sender {
    [timer invalidate];
    timer = nil;
    self.exBug.alpha = 0;
    self.exBug.hidden = YES;

    welldoneText.alpha = 1.0;
    
    [UIView animateWithDuration:1.0
                          delay:0.5
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         welldoneText.frame = welldoneTextFrame;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0
                                               delay:0.5
                                             options: UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.theStart.alpha = 1.0;

                                          }
                                          completion:^(BOOL finished){
                                              
                                          }];
                         
                     }];

}
@end
