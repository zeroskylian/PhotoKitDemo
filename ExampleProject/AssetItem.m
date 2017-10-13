//
//  AlAssetItem.m
//  ExampleProject
//
//  Created by 廉鑫博 on 2017/10/12.
//  Copyright © 2017年 廉鑫博. All rights reserved.
//

#import "AssetItem.h"
//由于系统返回的相册集名称为英文，我们需要转换为中文
NSString *titleOfAlbumForChinse(NSString *title) {
    if ([title isEqualToString:@"Slo-mo"]) {
        return @"慢动作";
    }else if ([title isEqualToString:@"Recently Added"]){
        return @"最近添加";
    }else if ([title isEqualToString:@"Favorites"]){
        return @"个人收藏";
    }else if ([title isEqualToString:@"Recently Deleted"]){
        return @"最近删除";
    }else if ([title isEqualToString:@"Videos"]){
        return @"视频";
    }else if ([title isEqualToString:@"All Photos"]){
        return @"所有照片";
    }else if ([title isEqualToString:@"Selfies"]){
        return @"自拍";
    }else if ([title isEqualToString:@"Screenshots"]){
        return @"屏幕快照";
    }else if ([title isEqualToString: @"Camera Roll"]) {
        return @"相机胶卷";
    }
    return title;
}
@implementation AssetItem
-(instancetype)initWithTitle:(NSString *)title fetchResult:(PHFetchResult<PHAsset *> *)fetchResult
{
    if (self = [super init]) {
        _title = title;
        _fetchResult = fetchResult;
    }
    return self;
}
-(NSString *)title
{
    return titleOfAlbumForChinse(_title);
}
@end
