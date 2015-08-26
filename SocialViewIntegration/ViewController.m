//
//  ViewController.m
//  SocialViewIntegration
//
//  Created by dmi on 24/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import "ViewController.h"
#import "FBSDKCoreKit/FBSDKCoreKit.h"
#import "FBSDKShareKit/FBSDKShareKit.h"
#import "FBSDKLoginKit/FBSDKLoginKit.h"
#import "FBImageCollectionViewCell.h"
@interface ViewController ()
{

    NSMutableArray *data;

}
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
    -(void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc]init];
//    
//    loginButton.center = self.view.center;
    
    [self.view addSubview:self.loginButton];
self.loginButton.readPermissions = @[@"public_profile",@"email",@"user_photos"];
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    
    [self.loginButton setDelegate:self];
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(profileUpdated:) name:FBSDKProfileDidChangeNotification object:nil];
    
    
//    self.loginButton.delegate = self;
    [self.loginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}




-(void)profileUpdated:(NSNotification *)notification
{
    [self toggleHiddenState:NO];
    self.lblUsername.text =[FBSDKProfile currentProfile].name;
    self.lblEmail.text = [FBSDKProfile currentProfile].userID;
    NSLog(@"User name : %@",[FBSDKProfile currentProfile].name);
    NSLog(@"User ID is : %@",[FBSDKProfile currentProfile].userID);
    
    
    NSDictionary *params = @{
                             @"source": @"{image-data}",
                             };
    
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/105412609571417/photos?fields=link,images"
                                  parameters:params
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        NSLog(@"result is: %@",result);
      
        NSLog(@"request is : %@",request);
        
        NSArray *imgdata = [result valueForKey:@"data"];
       
        self.imageData = nil;
        self.imageData = [[NSMutableArray alloc] initWithArray:imgdata];
        [self.imageCollectionView reloadData];
//        NSArray *imageData = result;
//        
//        
//        
//       // NSLog(@"%@",data);
//        
//         NSString  *ids = [data valueForKey:@"id"];
//        
//        NSArray *keys = [result allKeys];
//              NSLog(@"Keys are : %@ ",keys);
//        
//        
//        NSString *imageURL = [result objectForKey:@"source"];
//        
//        NSLog(@"Images URLs are : %@", imageURL);
//       
//        
//       // NSLog(@"Keys are : ",keys);
//        for (NSArray *data in imageData ) {
//            if(imageData != NULL)
//            {
//            
//                NSLog(@"ImageData is : %@",imageData);
//                
//                
//            }
//        }
        

        // Handle the result
    }];
    
    

    
    NSLog(@"%@",request);
    
}


-(void)viewWillAppear:(BOOL)animated
{


    [super viewWillAppear:animated];
    
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 NSLog(@"fetched user:%@", result);
//             }
//         }];
//    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    NSLog(@"%@",login);
    
    [login
     logInWithReadPermissions: @[@"public_profile",@"email" , @"user_photos"]
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             self.lblLoginStatus.text = @"You are logged in";
         }
     }];
}


//
//-(void)loginViewShowingLoggedInUser : (FBSDKLoginButton *)loginView
//{
//
//self.lblLoginStatus.text = @"You are logged in";
//    [self toggleHiddenState:NO];
//
//}


- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{

    NSLog(@"Login button test");
 self.lblLoginStatus.text = @"You are logged in";
   
    [self toggleHiddenState:NO];
    
    

}

-(void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    self.lblLoginStatus.text = @"You are logged out";

    NSLog(@"Log out button test");

}

-(void)toggleHiddenState:(BOOL)shouldHide
{

    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
    self.lblUsername.hidden = shouldHide;

}


//-(void)loginViewShowingLoggedOutUser : (FBSDKLoginButton *)loginView
//{
//
//    self.lblLoginStatus.text = @"You are logged out";
//    [self toggleHiddenState:YES];
//
//}


-(void)loginView : (FBSDKLoginButton *)loginView handleError:(NSError *)error
{

    NSLog(@"%@", [error localizedDescription]);

}

#pragma mark - UICollection View Delegate

-(NSInteger)collectionView :(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.imageData.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return self.imageData.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {


    FBImageCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    NSDictionary *facebookObject = self.imageData[indexPath.row];
    
    if (facebookObject) {
        cell.imageView.image = nil;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            
            NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:facebookObject[@"images"][0][@"source"]]];
            UIImage *image = [[UIImage alloc]initWithData:imageData2];
            if(image)
            {
            
                dispatch_async(dispatch_get_main_queue(), ^{
                
                if(cell.tag == indexPath.row)
                {
                
                    cell.imageView.image = image;
                    [cell setNeedsLayout];
                
                }
                });
            
            }
            
            
        });
    }
    
    
    return cell;

}

@end
