//
//  SUPickerView.h
//  PickerView
//
//  Created by jianbingZhou on 15/12/12.
//  Copyright (c) 2015年 jianbingZhou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    // 开始日期
    PickerViewTypeOfDatePicker = 0,
    
    // 结束日期
    PickerViewTypeOfPicker,
    
}PickerViewType;



@class JBPickerView;
@protocol JBPickerViewDelegate <NSObject>

@optional
//返回结果

- (void)pickerView:(JBPickerView *)pickView reslutString:(NSString *)resultString;

@end

@interface JBPickerView : UIView
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,weak) id<JBPickerViewDelegate> delegate;
@property (nonatomic,assign) PickerViewType type;

/**
 *
 *  @param array              需要显示的数组
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
- (instancetype)initPickviewWithArray:(NSArray *)array defaultIndex:(NSInteger)defaultIndex isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *  通过时间创建一个DatePicker
 *
 *  @param date               默认选中时间
 *  @param isHaveNavControler是否在NavControler之内
 *
 *  @return 带有toolbar的datePicker
 */
- (instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *   影藏本控件
 */
- (void)hide;
/**
 *  显示本控件
 */
- (void)show;
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color;

@end

