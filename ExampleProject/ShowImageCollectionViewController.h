//
//  ShowImageCollectionViewController.h
//  ExampleProject
//
//  Created by 廉鑫博 on 2017/10/12.
//  Copyright © 2017年 廉鑫博. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;

@interface ShowImageCollectionViewController : UICollectionViewController

@property (strong, nonatomic)PHFetchResult<PHAsset *> *fetchResult;
@end
