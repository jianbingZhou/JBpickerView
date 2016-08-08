//
//  ViewController.m
//  JBPickerViewDemo
//
//  Created by Terra MacBook on 16/8/8.
//  Copyright © 2016年 Jianbing Zhou. All rights reserved.
//

#import "ViewController.h"
#import "JBPickerView.h"

@interface ViewController ()<JBPickerViewDelegate> {
    NSArray *_cityArray;
    JBPickerView *_jbPickerView;
}

@end

@implementation ViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //省
    NSArray *province = @[@"北京", @"广西", @"广东"];
    //市
    NSDictionary *city = @{
              @"北京":@[@"朝阳区", @"东城区", @"西城区"],
              @"广西":@[@"桂林市", @"南宁市"],
              @"广东":@[@"惠州市", @"广州市", @"深圳市",@"东莞市"]};
              //县区
    NSDictionary  *country = @{
                  @"朝阳区":@[@"朝阳区1", @"朝阳区2", @"朝阳区3"],
                  @"东城区":@[@"东城区1", @"东城区2",@"东城区3",@"东城区4"],
                  @"西城区":@[@"西城区1", @"西城区2", @"西城区3",@"西城区4"],
                  @"桂林市":@[@"桂林市1", @"桂林市2", @"桂林市3"],
                  @"南宁市":@[@"南宁市1", @"南宁市2",@"南宁市3",@"南宁市4"],
                  @"惠州市":@[@"惠州市1", @"惠州市2", @"惠州市3",@"惠州市4"],
                  @"广州市":@[@"广州市1", @"广州市2", @"广州市3"],
                  @"深圳市":@[@"深圳市1", @"深圳市2",@"深圳市3",@"深圳市4"],
                  @"东莞市":@[@"东莞市1", @"东莞市2", @"东莞市3",@"东莞市4"],
                  };
    _cityArray = @[province,city,country];
}

#pragma mark - SUPickerViewDelegate
- (void)pickerView:(JBPickerView *)pickView reslutString:(NSString *)resultString {
    NSLog(@"***%@",resultString);
}

- (IBAction)dataPicker:(id)sender {
    _jbPickerView = [[JBPickerView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeTime isHaveNavControler:NO];
    _jbPickerView.delegate = self;
    _jbPickerView.type = PickerViewTypeOfDatePicker;
    [self.view addSubview:_jbPickerView];
    [_jbPickerView show];

}

- (IBAction)cityPicker:(id)sender {
    _jbPickerView = [[JBPickerView alloc] initPickviewWithArray:_cityArray defaultIndex:0 isHaveNavControler:NO];
    _jbPickerView.delegate = self;
    _jbPickerView.type = PickerViewTypeOfPicker;
    [self.view addSubview:_jbPickerView];
    [_jbPickerView show];
}
@end
