//
//  SUPickerView.m
//  PickerView
//
//  Created by jianbingZhou on 15/12/12.
//  Copyright (c) 2015年 jianbingZhou. All rights reserved.
//

#import "JBPickerView.h"
#import "AppDelegate.h"
#define JBToobarHeight 40
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface JBPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger pikcerViewDefaultIndex;
}
@property (nonatomic,strong) UIView * toolbar;
@property (nonatomic,strong) NSArray * dataArray;//二维数组
@property(nonatomic,assign) BOOL isHaveNavControler;//是否有导航
@property(nonatomic,assign) NSInteger pickeviewHeight;//控件高
@property(nonatomic,assign) NSDate *defaulDate;//默认时间
@property (nonatomic,assign) CGRect showRect;
@property (nonatomic,assign) CGRect hideRect;
@property(nonatomic,copy)NSString *resultString;
@property (nonatomic,retain) NSDate * date;

@end

@implementation JBPickerView
-(NSArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray=[[NSArray alloc] init];
    }
    return _dataArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpToolBar];
        
    }
    return self;
}
-(void)setUpToolBar{
    _toolbar=[self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    [self addSubview:_toolbar];
}

-(void)setToolbarWithPickViewFrame{
    _toolbar.frame=CGRectMake(0, 0,WIDTH, JBToobarHeight);
}


-(UIView *)setToolbarStyle{
    UIView *toolbar=[[UIView alloc] init];
    toolbar.backgroundColor = [UIColor lightGrayColor];
    //左按钮
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 7.5, 65, 25)];
    
    
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [leftBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview:leftBtn];
    leftBtn.layer.cornerRadius = leftBtn.bounds.size.height / 2;
    leftBtn.layer.masksToBounds = YES;
    leftBtn.backgroundColor = [UIColor greenColor];
    
     //右边
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH-10-65, 7.5, 65, 25)];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.layer.cornerRadius = rightBtn.bounds.size.height / 2;
    rightBtn.layer.masksToBounds = YES;
    rightBtn.backgroundColor = [UIColor greenColor];
    
    [toolbar addSubview:rightBtn];

    return toolbar;
}


-(instancetype)initPickviewWithArray:(NSArray *)array defaultIndex:(NSInteger)defaultIndex isHaveNavControler:(BOOL)isHaveNavControler
{

    self=[super init];
    if (self) {
        self.dataArray=array;
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
        if (_pickerView) {
            [_pickerView selectRow:defaultIndex inComponent:0 animated:YES];
        }
        self.type = PickerViewTypeOfPicker;
        self.backgroundColor = [UIColor lightGrayColor] ;
       pikcerViewDefaultIndex = defaultIndex;
    }
    return self;

}

-(void)setUpPickView{
    
    UIPickerView *pickView=[[UIPickerView alloc] init];
    _pickerView=pickView;
    pickView.delegate=self;
    pickView.dataSource=self;
    pickView.frame=CGRectMake(0, JBToobarHeight, WIDTH, pickView.frame.size.height);
    _pickeviewHeight=pickView.frame.size.height;
    [self addSubview:pickView];
}

-(void)setFrameWith:(BOOL)isHaveNavControler{
    CGFloat toolViewX = 0;
    CGFloat toolViewH = _pickeviewHeight+JBToobarHeight;
    CGFloat toolViewY;
    CGFloat toolViewY1;
    if (isHaveNavControler) {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH-50;
    }else {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH;
    }
    if (isHaveNavControler) {
        toolViewY1= [UIScreen mainScreen].bounds.size.height - 50;
    }else {
        toolViewY1= [UIScreen mainScreen].bounds.size.height;
    }

    CGFloat toolViewW = [UIScreen mainScreen].bounds.size.width;
    self.frame = CGRectMake(toolViewX, toolViewY1, toolViewW, toolViewH);
    _hideRect = CGRectMake(toolViewX, toolViewY1, toolViewW, toolViewH);
    _showRect = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
    
}


-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler
{
    self=[super init];
    if (self) {
        _defaulDate=defaulDate;
        [self setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode];
        [self setFrameWith:isHaveNavControler];
        self.type = PickerViewTypeOfDatePicker;
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;

}

-(void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode{
    UIDatePicker *datePicker=[[UIDatePicker alloc] init];
    datePicker.datePickerMode = datePickerMode;
    if (_defaulDate) {
        [datePicker setDate:_defaulDate];
    }
    datePicker.frame = CGRectMake(0, JBToobarHeight, WIDTH, datePicker.frame.size.height);
    _datePicker = datePicker;
    _pickeviewHeight = datePicker.frame.size.height;
    [self addSubview:datePicker];
}

-(void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
         self.frame = _hideRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

-(void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = _showRect;
    }];
    
}

#pragma mark piackView 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return _dataArray.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component ==0) {//一定是个数组
        NSArray *array =  self.dataArray[0];
        return array.count;
    } else if (component == 1) {//字典
        NSInteger index0 = [pickerView selectedRowInComponent:0];
        NSString *provinceName = self.dataArray[0][index0];
        NSDictionary *dictionary1 = (NSDictionary *)self.dataArray[1];
        NSArray *cityArray = [dictionary1 objectForKey:provinceName];
        return cityArray.count;
    } else {
        NSInteger index0 = [pickerView selectedRowInComponent:0];
        NSString *provinceName = self.dataArray[0][index0];
        NSDictionary *dictionary1 = (NSDictionary *)self.dataArray[1];
        NSArray *cityArray = [dictionary1 objectForKey:provinceName];
        
        NSInteger index1 = [pickerView selectedRowInComponent:1];
        NSString *cityName = cityArray[index1];
        
        NSDictionary *dictionary2 = (NSDictionary *)self.dataArray[2];
        NSArray *countArray  = [dictionary2 objectForKey:cityName];
        return countArray.count;
    }
}

#pragma mark UIPickerViewdelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component ==0) {//一定是个数组
        NSArray *array =  self.dataArray[0];
        return array[row];
    } else if (component == 1) {//字典
        NSInteger index0 = [pickerView selectedRowInComponent:0];
        NSString *provinceName = self.dataArray[0][index0];
        NSDictionary *dictionary1 = (NSDictionary *)self.dataArray[1];
        NSArray *cityArray = [dictionary1 objectForKey:provinceName];
        return cityArray[row];
    } else {
        NSInteger index0 = [pickerView selectedRowInComponent:0];
        NSString *provinceName = self.dataArray[0][index0];
        NSDictionary *dictionary1 = (NSDictionary *)self.dataArray[1];
        NSArray *cityArray = [dictionary1 objectForKey:provinceName];
        
        NSInteger index1 = [pickerView selectedRowInComponent:1];
        NSString *cityName = cityArray[index1];
        
        NSDictionary *dictionary2 = (NSDictionary *)self.dataArray[2];
        NSArray *countArray  = [dictionary2 objectForKey:cityName];
        return countArray[row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component == 0){
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }
    if(component == 1)
    [pickerView reloadComponent:2];
    NSInteger index0 = [pickerView selectedRowInComponent:0];
    NSInteger index1 = [pickerView selectedRowInComponent:1];
    NSInteger index2 = [pickerView selectedRowInComponent:2];
    NSString *provinceName = self.dataArray[0][index0];
    NSArray *citys = [self.dataArray[1] objectForKey:provinceName];
    NSString *cityName = citys[index1];
    NSArray *countrys = [self.dataArray[2] objectForKey:cityName];
    NSString *countName = countrys[index2];

    _resultString = [NSString stringWithFormat:@"%@-%@-%@",provinceName,cityName,countName];
    
    
}
//toolbar 按钮的监听
-(void)doneClick
{
    if (_datePicker) {
        _date = _datePicker.date;
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"HH:mm"];
        NSString *showtimeNew = [formatter1 stringFromDate:_date];
        _resultString = showtimeNew;

    }
    else if (_pickerView)
    {
        if (_resultString) {
            
        }else
        {
            NSString *provinceName = self.dataArray[0][pikcerViewDefaultIndex];
            
            NSString *cityName = [[self.dataArray[1] objectForKey:provinceName] objectAtIndex:0];
            NSString *countyName = [[self.dataArray[2] objectForKey:cityName] objectAtIndex:0];
            _resultString = [NSString stringWithFormat:@"%@-%@-%@",provinceName,cityName,countyName];
        }
        
    }
    
    if ([self.delegate respondsToSelector:@selector(pickerView:reslutString:)]) {
        [self.delegate pickerView:self reslutString:_resultString];
    }
    [self hide];
}

- (void)cancelClick
{
    if ([self.delegate respondsToSelector:@selector(pickerView:reslutString:)]) {
        [self.delegate pickerView:nil  reslutString:nil];
    }
    [self hide];
}
//CheckTimeRegulation
- (BOOL)TimeRegulation
{
    // hour system
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;// TURE == 12小时制
    return hasAMPM;
    
}

/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color{
    _pickerView.backgroundColor=color;
}
@end
