//
//  ViewController.m
//  ExampleProject
//
//  Created by 廉鑫博 on 2017/8/20.
//  Copyright © 2017年 廉鑫博. All rights reserved.
//

#import "ViewController.h"
#import "AssetItem.h"
#import "ShowImageCollectionViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)NSMutableArray<AssetItem *> *assetArr;

@property (strong, nonatomic)UITableView  *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assetArr = [NSMutableArray array];
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSArray *smartArr  = [self enumFetchResult:smartAlbums];
    if (smartAlbums.count > 0) {
         [self.assetArr addObjectsFromArray:smartArr];
    }
    // 列出所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    NSArray *topLevelArr  = [self enumFetchResult:topLevelUserCollections];
    if (topLevelArr.count > 0) {
        [self.assetArr addObjectsFromArray:topLevelArr];
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellId"];
    _tableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSArray<AssetItem *> *)enumFetchResult:(PHFetchResult *)result
{
    
    NSMutableArray *muarr = [NSMutableArray array];
    PHFetchOptions *option = [[PHFetchOptions alloc]init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:false]];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
    for (PHCollection *collection in result) {
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assCollection = (PHAssetCollection *)collection;
            PHFetchResult *assetReult = [PHAsset fetchAssetsInAssetCollection:assCollection options:option.copy];
            if (assetReult.count > 0) {
                if (![assCollection.localizedTitle containsString:@"Delete"]) {
                     [muarr addObject:[[AssetItem alloc] initWithTitle:assCollection.localizedTitle fetchResult:assetReult]];
                }
            }
        }
    }
    NSArray *resultArr = muarr.copy;
    return resultArr;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assetArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellId"];
    AssetItem *item = self.assetArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%lu)",item.title,(unsigned long)item.fetchResult.count];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth/4, kScreenWidth/4);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    ShowImageCollectionViewController *controller = [[ShowImageCollectionViewController alloc]initWithCollectionViewLayout:layout];
    AssetItem *item = self.assetArr[indexPath.row];
    controller.title = item.title;
    controller.fetchResult = item.fetchResult;
    [self.navigationController pushViewController:controller animated:true];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
