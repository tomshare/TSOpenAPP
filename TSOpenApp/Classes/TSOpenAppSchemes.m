//
//  TSOpenAppSchemes.m
//  Pods-TSOpenApp_Example
//
//  Created by tomshare on 2019/7/22.
//

#import "TSOpenAppSchemes.h"
#import <UIKit/UIKit.h>

NSString * NSStringFromTCH_OpenAPPSchemesType(TSOpenAppSchemesType type) {
    switch (type) {
        case TSOpenAppSchemesTypeJD:
            return @"openApp.jdMobile";
        case TSOpenAppSchemesTypeTaobao:
            return @"taobao";
        case TSOpenAppSchemesTypeTmall:
            return @"tmall";
        case TSOpenAppSchemesTypeWeiDianBuyer:
            return @"weidianbuyer";
        default:
            return nil;
    }
}

@interface TSOpenAppSchemes()

@property (nonatomic , strong)   NSDictionary           * appschemesDict;

@end
static TSOpenAppSchemes *_instance = nil;

@implementation TSOpenAppSchemes
+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TSOpenAppSchemes alloc] init];
    });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSBundle *bundel = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[TSOpenAppSchemes class]] pathForResource:@"TSOpenApp" ofType:@"bundle"]];
        NSString *path = [bundel pathForResource:@"ts_apps" ofType:@"plist"];
        self.appschemesDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return self;
}

- (void)OpenWithType:(TSOpenAppSchemesType)type
              itemid:(NSString *)itemid
         detailIndex:(NSInteger)detailIndex {
    
    [self OpenWithType:type itemid:itemid detailIndex:detailIndex webUrl:nil];
}


- (void)OpenWithType:(TSOpenAppSchemesType)type
              itemid:(NSString *)itemid
         detailIndex:(NSInteger)detailIndex
              webUrl:(NSString *)webUrl {
    NSArray *appsArr = [self.appschemesDict objectForKey:NSStringFromTCH_OpenAPPSchemesType(type)];
    if (detailIndex > appsArr.count-1) {
        [self openUrl:nil webUrl:webUrl];
        return;
    }
    NSString *openAppUrl = appsArr[detailIndex];
    openAppUrl = [openAppUrl stringByReplacingOccurrencesOfString:@"(itemid)" withString:itemid];
    [self openUrl:openAppUrl webUrl:webUrl];
    
}

- (void)openUrl:(NSString *)urlString
         webUrl:(NSString *)weburl {
    NSURL *websUrl;
    if (weburl) {
        websUrl = [NSURL URLWithString:[weburl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    if (urlString && urlString.length > 0) {
        //打开app
        NSURL *appurl = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        if ([[UIApplication sharedApplication] canOpenURL:appurl]) {
            [self applicationOpenUrl:appurl];
        }
        //打开网页
        else  {
            //尝试打开app ios10以后的系统
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:appurl options:@{} completionHandler:^(BOOL success) {
                    if (!success) {
                        //失败打开网页
                        [self applicationOpenUrl:websUrl];
                    }
                }];
            }
            //打开网页
            else {
                [self applicationOpenUrl:websUrl];
            }
        }
    }
    else if (websUrl) {
        [self applicationOpenUrl:websUrl];
    }
}

- (void)applicationOpenUrl:(NSURL *)url {
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            if (success) {
                
            }
        }];
    }
    else {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    
    
}

@end
