//
//  XYConfig.m
//  IflyDemo
//
//  Created by 张建军 on 15/10/29.
//  Copyright (c) 2015年 张建军. All rights reserved.
//

#import "XYConfig.h"
@implementation XYConfig

#pragma mark - 初始化
-(instancetype)init
{
    self =  [super init];
    
    if (self) {
        
        [self defaultSetting];
    }
    
    return self;
}

#pragma mark - 单例
+(instancetype)shareInstance
{
    static XYConfig *xyConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        xyConfig = [[XYConfig alloc]init];
    });
    
    return xyConfig;
}

//默认参数设置
-(void)defaultSetting
{
    //语速
    self.speed = @"50";
    //音量
    self.volume = @"50";
    //音调
    self.pitch = @"50";
    //采样率
    self.sampleRate = @"16000";
    //    云端支持发音人：小燕（xiaoyan）、小宇（xiaoyu）、凯瑟琳（Catherine）、
    //    亨利（henry）、玛丽（vimary）、小研（vixy）、小琪（vixq）、
    //    小峰（vixf）、小梅（vixm）、小莉（vixl）、小蓉（四川话）、
    //    小芸（vixyun）、小坤（vixk）、小强（vixqa）、小莹（vixying）、 小新（vixx）、楠楠（vinn）老孙（vils）<br>
    //    对于网络TTS的发音人角色，不同引擎类型支持的发音人不同，使用中请注意选择。

    //发音角色
    self.vcnNickNameArray = @[@"小燕", @"小宇", @"小研", @"小琪",@"小峰",@"小新",@"小坤"];;
    //发音人名称
    self.vcnIdentiferArray = @[@"xiaoyan",@"xiaoyu",@"vixy",@"vixq",@"vixf",@"vixx",@"vixk"];
    //发音人
    self.vcnName = _vcnIdentiferArray[0];
    //引擎类型
    self.engineType = @"auto";
    
}
@end
