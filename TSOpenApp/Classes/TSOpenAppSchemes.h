//
//  TSOpenAppSchemes.h
//  Pods-TSOpenApp_Example
//
//  Created by tomshare on 2019/7/22.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TSOpenAppSchemesType) {
    TSOpenAppSchemesTypeJD = 0,
    TSOpenAppSchemesTypeTmall = 1,
    TSOpenAppSchemesTypeTaobao = 2,
};

extern NSString * NSStringFromTSOpenAppSchemesType(TSOpenAppSchemesType type);


@interface TSOpenAppSchemes : NSObject

+ (instancetype)shareManager;



- (void)OpenWithType:(TSOpenAppSchemesType)type
              itemid:(NSString *)itemid
         detailIndex:(NSInteger)detailIndex;



- (void)OpenWithType:(TSOpenAppSchemesType)type
              itemid:(NSString *)itemid
         detailIndex:(NSInteger)detailIndex
              webUrl:(NSString *)webUrl;
@end


