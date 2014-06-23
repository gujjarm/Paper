//
//  MainViewController.m
//  Paper
//
//  Created by Manish Gujjar on 6/22/14.
//  Copyright (c) 2014 Manish Gujjar. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet UIView *swipeView;

@property (strong, nonatomic) IBOutlet UIImageView *headlinesImageView;

@property (strong, nonatomic) IBOutlet UIScrollView *newsScrollView;


@property (strong, nonatomic) IBOutlet UIImageView *newsImageView;

- (IBAction)onPan:(UIPanGestureRecognizer *)sender;


@end

@implementation MainViewController


float currentPanYPosition;
float startingPanYPosition;
float distancePanned;
float currentSwipeViewYPosition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    NSLog((@" Inside onPan"));

    CGPoint point = [ sender locationInView:self.view];
    CGPoint velocity = [ sender velocityInView:self.view];
    
    CGRect frame = self.swipeView.frame;
    
    self.newsScrollView.contentSize = self.newsImageView.frame.size;
    [self.newsScrollView setScrollEnabled:true];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        float startingHeight = self.swipeView.frame.origin.y;
        startingPanYPosition = point.y;
        currentSwipeViewYPosition = startingHeight;
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        
        currentPanYPosition = point.y;
        distancePanned = point.y - startingPanYPosition;
        
        frame.origin.y = currentSwipeViewYPosition + distancePanned;
        
        [ UIView animateWithDuration:2 animations:^{
            self.swipeView.frame=frame;
        }];
    
        
        if (self.swipeView.frame.origin.y > 520) {
            frame.origin.y = 520;
            self.swipeView.frame=frame;
        }
        
        if (self.swipeView.frame.origin.y < 0 ) {
            frame.origin.y = 0;
            [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:100 initialSpringVelocity:0 options:0
                             animations:^{ self.swipeView.frame=frame;
                             } completion:nil];
        }
    
    }

    else if (sender.state == UIGestureRecognizerStateEnded){
    
        if (velocity.y >= 0) {
            frame.origin.y=520;
            self.swipeView.frame=frame;
        }
        else if (velocity.y < 0){
            frame.origin.y = 0;
            [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:100 initialSpringVelocity:0 options:0
                             animations:^{
                                 self.swipeView.frame = frame;
                              } completion:nil];
            
        }
    
    
    }
    
    
}
@end
