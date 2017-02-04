//
//  BookFlightSearchView.h
//  PromiseKitDemo
//
//  Created by rongyu100 on 2017/1/20.
//  Copyright © 2017年 Rongyu100. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BookFlightType) {
    /// 单程
    BookFlightTypeSingle = 1,
    /// 往返
    BookFlightTypeRound  = 2,
};


@interface BookFlightSearchView : UIView

+ (instancetype)initBookFlightSearchView;

@property (nonatomic, copy, readonly) NSString *startCity;
@property (nonatomic, copy, readonly) NSString *endCity;

@property (nonatomic, copy, readonly) NSString *startDate;
@property (nonatomic, copy, readonly) NSString *endDate;

@property (nonatomic, assign, readonly) BookFlightType bookFlightType;


@property (nonatomic, copy) void((^cityInfoCallBack)(NSString *start,NSString *end,BookFlightType type));
@property (nonatomic, copy) void((^dateInfoCallBack)(NSArray *dates,BookFlightType type));
@property (nonatomic, copy) void((^beginSearchCallBack)(BookFlightType type));

/// weak type
- (void)setCurrentController:(UIViewController *)controller;

- (void)setCurrentBookFlightType:(BookFlightType)bookFlightType;

- (void)setBeginCity:(NSString *)beginCity endCity:(NSString *)endCity;

- (void)setBeginDate:(NSString *)beginDate endDate:(NSString *)endDate;


@end
