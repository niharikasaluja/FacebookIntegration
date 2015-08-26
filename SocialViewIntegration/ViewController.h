//
//  ViewController.h
//  SocialViewIntegration
//
//  Created by dmi on 24/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBSDKCoreKit/FBSDKCoreKit.h"
#import "FBSDKShareKit/FBSDKShareKit.h"
#import "FBSDKLoginKit/FBSDKLoginKit.h"

@interface ViewController : UIViewController <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKProfilePictureView *profilePicture;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property NSMutableArray *imageData;

@end

