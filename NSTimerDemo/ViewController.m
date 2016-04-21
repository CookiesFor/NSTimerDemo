//
//  ViewController.m
//  NSTimerDemo
//
//  Created by SIMPLE PLAN on 16/4/21.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>


@interface ViewController ()

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)NSString * auctionTime;
@property(nonatomic)NSInteger secondCountDown;
@property(nonatomic,strong)UIButton *sureButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _label = [[UILabel alloc]init];
    //设置label的属性值
    _label.backgroundColor = [UIColor redColor];
    _label.adjustsFontSizeToFitWidth = YES;
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    //坐标，，大小
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(200, 100));
        
        
    }];
    
    
    //正计时
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate distantPast]];

    
    
    //倒计时
    _secondCountDown = 100;
    
    NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTIme:) userInfo:nil repeats:YES];
    [timer1 setFireDate:[NSDate distantPast]];
    
    
    //如果想要字的闪动效果，改为UIButtonTypeSystem即可
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_sureButton];
    
    [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureButton setBackgroundColor:[UIColor redColor]];
    
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label.mas_bottom).offset(50);
        make.left.equalTo(_label.mas_left);
        make.size.mas_equalTo(CGSizeMake(200, 100));
        
    }];
    
    
    
    
}

#pragma mark -正计时,距离过去的某个时间有多久

- (void)timerFire:(NSTimer *)timer
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:2015];
    [components setMonth:11];
    [components setDay:19];
    [components setHour:17];
    [components setMinute:60];
    [components setSecond:0];
    NSDate *fireDate = [calendar dateFromComponents:components];//目标时间
    NSDate *today = [NSDate date];//当前时间
    unsigned int unitFlags = kCFCalendarUnitHour|kCFCalendarUnitMinute|kCFCalendarUnitSecond;
    NSDateComponents *d = [calendar components:unitFlags fromDate:fireDate toDate:today options:0];//计算时间差
    _label.text = [NSString stringWithFormat:@"%ld小时%ld分%ld秒",(long)[d hour], (long)[d minute], [d second]];//倒计时显示
}

#pragma mark -倒计时

-(void)countDownTIme:(NSTimer *)timer
{
    //倒计时－1
    _secondCountDown--;
    
    
    
    [_sureButton setTitle:[NSString stringWithFormat:@"剩余%ld",_secondCountDown] forState:UIControlStateNormal];

    if (_secondCountDown<=0) {
            [_sureButton setTitle:@"倒计时走完了呢!!" forState:UIControlStateNormal];
    }
    
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
