//
//  ViewController.m
//  TweeterShare
//
//  Created by 徐冰 on 09/02/2016.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UITextView *facebookTextView;
@property (weak, nonatomic) IBOutlet UITextView *anyTextView;

//- (void) showAlertMessage: (NSString *) myMessage;
- (void) configureTweetTextView;
- (void) configureFacebookTextView;
- (void) configureAnyTextView;
- (void) showMessage: (NSString *) myMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTweetTextView];
    [self configureFacebookTextView];
    [self configureAnyTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------Assignment for week 1----------------------------//
- (void) configureTweetTextView {
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;
}

- (void) configureFacebookTextView {
    self.facebookTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.9 blue:0.9 alpha:1.0].CGColor;
    self.facebookTextView.layer.cornerRadius = 10.0;
    self.facebookTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.6].CGColor;
    self.facebookTextView.layer.borderWidth = 2.5;
}

- (void) configureAnyTextView {
    self.anyTextView.layer.backgroundColor = [UIColor colorWithRed:0.8 green:1.0 blue:0.8 alpha:1.0].CGColor;
    self.anyTextView.layer.cornerRadius = 20.0;
    self.anyTextView.layer.borderColor = [UIColor colorWithWhite:0.2 alpha:0.8].CGColor;
    self.anyTextView.layer.borderWidth = 3.0;
}

- (void) showMessage:(NSString *)myMessage {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"Error message" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okey" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)tweetShareAction:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *tweetVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if (self.tweetTextView.text.length <= 140) {
            [tweetVC setInitialText:self.tweetTextView.text];
        } else {
            [tweetVC setInitialText:[self.tweetTextView.text substringToIndex:140]];
        }
        [self presentViewController:tweetVC animated:YES completion:nil];
        
    } else {
        [self showMessage:@"Please sign in to Twitter first."];
    }
}

- (IBAction)facebookShareAction:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook ]) {
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookVC setInitialText:self.facebookTextView.text];
        [self presentViewController:facebookVC animated:YES completion:nil];
    } else {
        [self showMessage:@"Please sign in to Facebook first."];
    }
}

- (IBAction)anyShareAction:(id)sender {
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.anyTextView.text] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)noAction:(id)sender {
    [self showMessage:@"No action for this button."];
}


//--------------------------Practice in the class----------------------------//

//- (void)showAlertMessage: (NSString *) myMessage {
//    UIAlertController *alertController;
//    alertController = [UIAlertController alertControllerWithTitle:@"SocialShare"
//                                                          message:myMessage
//                                                   preferredStyle:UIAlertControllerStyleAlert];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Okey"
//                                                        style:UIAlertActionStyleDefault
//                                                      handler:nil]];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//}

//- (IBAction)showShareAction:(id)sender {
//    if ([self.tweetTextView isFirstResponder]) {
//        [self.tweetTextView resignFirstResponder];
//    }
//    
//    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Share" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
//                                                           style:UIAlertActionStyleDefault
//                                                         handler:nil];
//    
//    UIAlertAction *tweetAction =[UIAlertAction actionWithTitle:@"Tweet"
//                                             style:UIAlertActionStyleDefault
//                                           handler:^(UIAlertAction *action) {
//                                        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
//                                            SLComposeViewController *tweeterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//                                            if ([self.tweetTextView.text length] < 140) {
//                                                [tweeterVC setInitialText:self.tweetTextView.text];
//                                            }
//                                            else {
//                                                NSString *shortText = [self.tweetTextView.text substringToIndex:140];
//                                                [tweeterVC setInitialText:shortText];
//                                            }
//                                            [self presentViewController:tweeterVC animated:YES completion:nil];
//                                                       
//                                        } else {
//                                            [self showAlertMessage:@"Please sign in to Twitter before you tweet"];
//                                        }
//    }];
//    
//    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
//            SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//            [facebookVC setInitialText:self.tweetTextView.text];
//            [self presentViewController:facebookVC animated:YES completion:nil];
//            
//        } else {
//            [self showAlertMessage:@"Please sign in to Facebook"];
//        }
//        
//    }];
//    
//    
//    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"More" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        UIActivityViewController *moreVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.tweetTextView.text] applicationActivities:nil];
//        [self presentViewController:moreVC animated:YES completion:nil];
//    }];
//    
//    [actionController addAction:tweetAction];
//    [actionController addAction:facebookAction];
//    [actionController addAction:moreAction];
//    [actionController addAction:cancelAction];
//    
//    
//    [self presentViewController:actionController animated:YES completion:nil];
//}

@end
