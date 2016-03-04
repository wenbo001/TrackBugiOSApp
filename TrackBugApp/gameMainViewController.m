//
//  gameMainViewController.m
//  TrackBugApp
//
//  Created by wenbo on 12/8/15.
//  Copyright © 2015 WenboLiu. All rights reserved.
//

#import "gameMainViewController.h"
#import "gameEndViewController.h"
#import "levelViewController.h"
#import "slGameData.h"

@interface gameMainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ScoreWithTimer;
- (IBAction)homeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *lifeImg1;
@property (weak, nonatomic) IBOutlet UIImageView *lifeImg2;
@property (weak, nonatomic) IBOutlet UIImageView *lifeImg3;

@end

NSMutableAttributedString* agreeAttributedString ;
NSString * content;
NSMutableAttributedString* bugAttributedString;
NSDictionary * dictionary;
NSMutableArray * lifeImgArray;
gameEndViewController * vcend;

@implementation gameMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"GameBg"]]];
    [self setupApp];
    
    self.codeTextView.editable=NO;
    self.codeTextView.selectable=NO;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ViewData"
                                                     ofType:@"xml"];
    content = [NSString stringWithContentsOfFile:path
                                        encoding:NSUTF8StringEncoding
                                           error:NULL];
    self.codeTextView.attributedText = [self tapAttributedString];
    
    self.codeTextView.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BgCloud"]];
    imageView.frame = CGRectMake(0, self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height/2);
    [self.view addSubview:imageView];
    [self.view bringSubviewToFront:self.codeTextView];
    [self addImage];
  
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(txvTextTouched:)];
    [self.codeTextView addGestureRecognizer:tap];
}
-(void)addImage{
    self.scoreLabel.backgroundColor = [UIColor clearColor];
    UIImageView * imageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ButtonBg1"]];
    imageBg.frame = CGRectMake(0, 0, self.scoreLabel.frame.size.width, self.scoreLabel.frame.size.height);
    [self.view addSubview:imageBg];
    [self.view bringSubviewToFront:self.scoreLabel];
}
- (NSAttributedString *)tapAttributedString {
    
    NSMutableParagraphStyle *paragraph= [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentJustified;
    paragraph.lineSpacing = 3;
    paragraph.lineHeightMultiple = 1.25;
    
    UIFont* font = [UIFont fontWithName:@"Verdana" size:24];
    UIColor* textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0f];
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : textColor,
                             NSFontAttributeName : font,
                             NSLigatureAttributeName:@0};
    
    agreeAttributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attrs];
    
    dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"int", @"buga", @"=",@"bugb", @" ",@"bugc", nil];
    
    for (NSString *key in dictionary.allKeys) {
        NSRange range =[[agreeAttributedString string] rangeOfString:key];
        bugAttributedString =[[NSMutableAttributedString alloc] initWithString:dictionary[key]
                                                                    attributes:@{
                                                                                 @"bugTap" : @(YES),
                                                                                 NSForegroundColorAttributeName : textColor,
                                                                                 NSFontAttributeName : font,
                                                                                 NSLigatureAttributeName:@0
                                                                                 }];
    
        if(range.location != NSNotFound){
            [agreeAttributedString replaceCharactersInRange:range withAttributedString:bugAttributedString];
        }
        
    }
    
    [agreeAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, [agreeAttributedString length])];
    
    return agreeAttributedString;
}

-(void)txvTextTouched:(UITapGestureRecognizer *)recognizer
{
    UITextView *textView = (UITextView *)recognizer.view;
    
    NSLayoutManager *layoutManager = textView.layoutManager;
    CGPoint location = [recognizer locationInView:textView];
    location.x -= textView.textContainerInset.left;
    location.y -= textView.textContainerInset.top;
    
    NSUInteger characterIndex;
    characterIndex = [layoutManager characterIndexForPoint:location
                                           inTextContainer:textView.textContainer
                  fractionOfDistanceBetweenInsertionPoints:NULL];
    
    if (characterIndex < textView.textStorage.length) {
        
        NSRange range0;
        //        NSRange range1;
        id bugValue = [textView.textStorage attribute:@"bugTap" atIndex:characterIndex effectiveRange:&range0];
        
        id goodValue = [textView.textStorage attribute:@"Tapped" atIndex:characterIndex effectiveRange:&range0];
        
        if(bugValue)
        {
            [agreeAttributedString removeAttribute:@"bugTap" range:range0];
            //            [agreeAttributedString replaceCharactersInRange:range0 withString:@"cooooooool"];
            [agreeAttributedString addAttributes:@{
                                                   @"Tapped" : @(YES),
                                                   NSForegroundColorAttributeName : [UIColor greenColor]} range:range0];
            
            self.codeTextView.attributedText=agreeAttributedString;
            
            NSLog(@"%@",NSStringFromRange(range0));
            self.scoreCount++;
            self.yourScore = self.scoreCount;
            self.scoreLabel.text =[NSString stringWithFormat:@"Score:%li",(long)self.yourScore];

            if (self.scoreCount ==  [dictionary count]) {
                
                //get final score based the time you left
                if ((4 > self.seconds)&&( self.seconds >0) ){
                    self.yourScore = self.scoreCount + self.seconds;
                }else if(( 7 > self.seconds)&&( self.seconds >3)){
                    self.yourScore = self.scoreCount + self.seconds * 2;
                }else {
                    self.yourScore = self.scoreCount + self.seconds * 3;
                }
                [self stopGameWithDifferentScore];
            }

            return;
        }
        
        if ((agreeAttributedString.string) &&(!bugValue))
            
        {
            if (goodValue) {
                NSLog(@"hi, you clicked me");
            }else{
                self.lifeCount--;
//                self.lifeLabel.text =[NSString stringWithFormat:@"Life: %li",(long)self.lifeCount];
                
                switch (self.lifeCount) {
                    
                    case 0:
                        self.lifeImg1.alpha = 0;
                        self.lifeImg2.alpha = 0;
                        self.lifeImg3.alpha = 0;
                        [self stopGame];
                        break;
                    
                    case 1:
                        self.lifeImg1.alpha = 1;
                        self.lifeImg2.alpha = 0;
                        self.lifeImg3.alpha = 0;
                        break;
                    case 2:
                        self.lifeImg1.alpha = 1;
                        self.lifeImg2.alpha = 1;
                        self.lifeImg3.alpha = 0;
                        break;
                    case 3:
                        self.lifeImg1.alpha = 1;
                        self.lifeImg2.alpha = 1;
                        self.lifeImg3.alpha = 1;
                    default:
                        break;
                }
                
                
//                //loose: run out of life
//                if (self.lifeCount == 0) {
//                }

                NSLog(@"goodTap TAPPED,%lu",(unsigned long)characterIndex);
                
                return;
            }
        }
    }
}


-(void) setupApp{
    self.seconds = 10;
    self.lifeCount = 3;
    self.scoreCount = 0;
    self.ScoreWithTimer.alpha = 0;

//    self.lifeLabel.text =[NSString stringWithFormat:@"Life: %i",3];
    self.scoreLabel.text =[NSString stringWithFormat:@"Score: %i",0];
    
    self.timerLabel.text =[NSString stringWithFormat:@"%i",10];
   
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(subtractTime)
                                                userInfo:nil
                                                 repeats:YES];
}

-(void) subtractTime{
    self.seconds--;
    self.timerLabel.text =[NSString stringWithFormat:@"%li",(long)self.seconds];
    //loose: time is up
    if (self.seconds == 0) {
        [self stopGame];
    }
}

-(void)stopGame{
    
            [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
            gameEndViewController * vcend = [self.storyboard instantiateViewControllerWithIdentifier:@"gameEndNav"];
            //reset gamedata
            [[slGameData sharedGameData] reset];
    
            NSString* finalNewString = [NSString stringWithFormat:@"%li", (long)self.yourScore];
            vcend.finalScore = finalNewString;
            [self presentViewController:vcend animated:YES completion:nil];
    
}

-(void)stopGameWithDifferentScore{
    self.scoreLabel.text =[NSString stringWithFormat:@"Score:%li",(long)self.yourScore];
    self.ScoreWithTimer.text =[NSString stringWithFormat:@"%li",(long)self.yourScore];
    
    [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
    vcend = [self.storyboard instantiateViewControllerWithIdentifier:@"gameEndNav"];
    NSString* finalNewString = [NSString stringWithFormat:@"%li", (long)self.yourScore];
    vcend.finalScore = finalNewString;
    
    [slGameData sharedGameData].datascore =self.yourScore;
    //gamedata
    [slGameData sharedGameData].highScore = MAX([slGameData sharedGameData].datascore,
                                                [slGameData sharedGameData].highScore);
    [[slGameData sharedGameData] save];
    //reset gamedata
    [[slGameData sharedGameData] reset];
    
    self.scoreLabel.alpha = YES;
    self.ScoreWithTimer.alpha = 0;
    
    //welldone
    UITextView * welldoneText = [[UITextView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-150, -self.view.frame.size.height/2, 300, 60)];
    [welldoneText setTextAlignment:NSTextAlignmentCenter];
    welldoneText.backgroundColor = nil;
    welldoneText.text = @"Well Done";
    welldoneText.textColor = [UIColor whiteColor];
    welldoneText.font = [UIFont fontWithName:@"Thirteen Pixel Fonts" size:36.0];
    welldoneText.editable = NO;
    welldoneText.selectable = NO;
    [self.view addSubview:welldoneText];
    
    CGRect welldoneTextFrame = welldoneText.frame;
    welldoneTextFrame.origin.y = self.timerLabel.frame.origin.y;
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionShowHideTransitionViews
                     animations:^{
                         self.scoreLabel.hidden = NO;
                         self.ScoreWithTimer.alpha = 1.0;
                         self.timerLabel.alpha = 0;

                     }completion:^(BOOL finished) {
                         [UIView animateWithDuration:1.0
                                               delay:0
                                             options: UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              welldoneText.frame = welldoneTextFrame;

                                          } completion:^(BOOL finished) {
                                              [UIView animateWithDuration:1.5
                                                                    delay:1.5
                                                                  options: UIViewAnimationOptionCurveEaseOut
                                                               animations:^{
                                                                   self.codeTextView.alpha = 0;
                                                                   
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self presentViewController:vcend animated:YES completion:nil];
                                                               }];

                                          }];

                        }];

}

- (void) stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (IBAction)homeButton:(id)sender {
    [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
    levelViewController * vcLevel = [self.storyboard instantiateViewControllerWithIdentifier:@"levelNav"];
    [self presentViewController:vcLevel animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
