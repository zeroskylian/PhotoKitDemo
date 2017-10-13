//
//  AlAssetItem.h
//  ExampleProject
//
//  Created by 廉鑫博 on 2017/10/12.
//  Copyright © 2017年 廉鑫博. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Photos;
@interface AssetItem : NSObject
@property (strong, nonatomic)NSString *title;

@property (strong, nonatomic)PHFetchResult<PHAsset *> *fetchResult;

-(instancetype)initWithTitle:(NSString *)title fetchResult:(PHFetchResult<PHAsset *> *)fetchResult;
@end
