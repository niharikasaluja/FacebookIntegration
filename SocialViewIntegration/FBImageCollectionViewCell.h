//
//  FBImageCollectionViewCell.h
//  SocialViewIntegration
//
//  Created by dmi on 26/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBImageCollectionViewCell : UICollectionViewCell <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
