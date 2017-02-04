//
//  BookFlightSearchView.m
//  PromiseKitDemo
//
//  Created by xiaerfei on 2017/1/20.
//  Copyright © 2017年 Rongyu100. All rights reserved.
//

#import "BookFlightSearchView.h"

@interface BookFlightSearchView ()

@property (weak, nonatomic) IBOutlet UIButton *singleTripButton;
@property (weak, nonatomic) IBOutlet UIButton *roundTripButton;

@property (weak, nonatomic) IBOutlet UILabel *startCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *endCityLabel;

@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moveLineLeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateLineLeading;

@property (nonatomic, copy, readwrite) NSString *startCity;
@property (nonatomic, copy, readwrite) NSString *endCity;

@property (nonatomic, copy, readwrite) NSString *startDate;
@property (nonatomic, copy, readwrite) NSString *endDate;

@property (nonatomic, assign, readwrite) BookFlightType bookFlightType;



@end


@implementation BookFlightSearchView
{
    __weak UIViewController *_controller;
    
    BOOL _isSingleTrip;
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    self.dateLineLeading.constant = (CGRectGetWidth([UIScreen mainScreen].bounds) - 120)/2.0f;
    self.endDateLabel.hidden = YES;
    
    self.bookFlightType = BookFlightTypeSingle;
    
    self.startCity = @"上海";
    self.endCity   = @"北京";
    
    [self setBeginCity:self.startCity endCity:self.endCity];
    
    self.startDate = @"2017-01-20";
    self.endDate   = @"2017-01-26";
    
    [self setBeginDate:self.startDate endDate:self.endDate];
    
    self.searchButton.layer.masksToBounds = YES;
    self.searchButton.layer.cornerRadius  = 5;
}


+ (instancetype)initBookFlightSearchView
{
    BookFlightSearchView *bookFlightSearchView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"BookFlightSearchView" owner:nil options:nil] firstObject];
    return bookFlightSearchView;
}

- (void)setCurrentController:(UIViewController *)controller
{
    _controller = controller;
}

- (void)setCurrentBookFlightType:(BookFlightType)bookFlightType
{
    self.bookFlightType = bookFlightType;
}

- (void)setBeginCity:(NSString *)beginCity endCity:(NSString *)endCity
{
    self.startCity = beginCity;
    self.endCity   = endCity;
    self.startCityLabel.text = self.startCity;
    self.endCityLabel.text   = self.endCity;
}

- (void)setBeginDate:(NSString *)beginDate endDate:(NSString *)endDate
{
    self.startDate = beginDate;
    self.endDate   = endDate;
    
    self.startDateLabel.attributedText = [self addAttriOfDateLabel:self.startDate bookFlightType:BookFlightTypeSingle];
    self.startDateLabel.textAlignment  = NSTextAlignmentCenter;
    self.endDateLabel.attributedText   = [self addAttriOfDateLabel:self.endDate bookFlightType:BookFlightTypeRound];
}

#pragma mark - event responses

/// 单程
- (IBAction)singleTripAction:(id)sender {
    self.moveLineLeading.constant = 0;
    self.dateLineLeading.constant = (CGRectGetWidth(self.bounds) - 120)/2.0f;
    self.endDateLabel.hidden = YES;
    self.startDateLabel.textAlignment = NSTextAlignmentCenter;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.singleTripButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.roundTripButton setTitleColor:[UIColor colorWithWhite:0 alpha:0.75] forState:UIControlStateNormal];
        _bookFlightType = BookFlightTypeSingle;
    }];
}
/// 返程
- (IBAction)roundTripAction:(id)sender {
    self.moveLineLeading.constant = CGRectGetWidth(self.bounds)/2.0f;
    self.dateLineLeading.constant = 15;
    self.startDateLabel.textAlignment = NSTextAlignmentLeft;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.roundTripButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.singleTripButton setTitleColor:[UIColor colorWithWhite:0 alpha:0.75] forState:UIControlStateNormal];
        _bookFlightType = BookFlightTypeRound;
        self.endDateLabel.hidden = NO;
    }];
}

/// 切换出发城市和到达城市
- (IBAction)switchStartAndEndAction:(id)sender {
    [self switchCitys];
}
/// 开始搜索
- (IBAction)searchAction:(id)sender {
    
}
/// 出发城市 Tap
- (IBAction)startCityTap:(id)sender {
}
/// 到达城市 Tap
- (IBAction)endCityTap:(id)sender {
}

/// 出发日期 Tap
- (IBAction)startDateTap:(id)sender {
}
/// 到达日期 Tap
- (IBAction)endDateTap:(id)sender {
}


#pragma mark - private methods

- (void)switchCitys
{
    NSString *temp = self.startCity;
    self.startCity = self.endCity;
    self.endCity   = temp;
    
    self.startCityLabel.text = self.startCity;
    self.endCityLabel.text   = self.endCity;
}

- (NSAttributedString *)addAttriOfDateLabel:(NSString *)dateString bookFlightType:(BookFlightType)bookFlightType
{
    NSString *tipString = bookFlightType == BookFlightTypeSingle ? @"出发日期":@"返程日期";
    
    NSString *string = [NSString stringWithFormat:@"%@\n%@",tipString,dateString];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = [string rangeOfString:dateString];
    
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5;
    paragraph.alignment   = bookFlightType == BookFlightTypeSingle ? NSTextAlignmentLeft:NSTextAlignmentRight;
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, string.length)];
    return attri;
}



@end
